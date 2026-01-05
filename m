Return-Path: <linux-pm+bounces-40183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 011ABCF3436
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 12:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 795EE303BA84
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 11:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA365331212;
	Mon,  5 Jan 2026 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JX38Z7ZH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A02330B0C
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767612452; cv=none; b=ICyhFddZK03vnDxc2xeK/lA4uZjsAcIeFKCjtdy8boe3bhcbGMPsrM1RuGutbHRIKFIfXgBmbQceqq9hqdYHWt6gxloLUdYgjj9G/H8PbqacK4WfF/+R1Wclo4MizKAqjXkDXDHQihRCwZ0KXfedzIZFRP8PiIUb9V81tLtFRLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767612452; c=relaxed/simple;
	bh=M0rheODQq5/Ix29q4Rp5TwsRkiwe96cL6d5KUR2PhLI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=DZtS0gclFSSEwpcN4nsvL0dOem4nPE7e4WsU+GEFO/IDwBoINMvlY/eDdak/6vusyqZbGLXwayVamC2YU5t8f56kwys6qWTyljLOW4vC+dwMC+Esxcbta+RFncxZAkLBZWURzzauBB0bsvg8MJkyXJbUzG1A9/Cr6psRi4MNYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JX38Z7ZH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so141019415e9.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 03:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767612445; x=1768217245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M0rheODQq5/Ix29q4Rp5TwsRkiwe96cL6d5KUR2PhLI=;
        b=JX38Z7ZH/NnTL71H7a8zo7MKz5e0acojk+lgeO8jolJfy6Yb+ctLFLSyGefgbfaKGO
         +srkdhB6qcW8kLgn2gn79nDuwgSCEfmwUc9LH8szf2kRF4aC2E6CWPr+5Q/JUUMZoJoy
         vCFUxzRWlSj/kl1bKFKO8qC6IPWXjEDf4+hn9KrpxRRxMiUhZrl8CQOZq+q3kSpksB27
         2TtpT5dtBm+TaBLX+FgdeVQlG7fflxA4pLa9WpbDvWXOLK2e2PCkYPfJHSE2qNw5Dl+f
         t0/RdGh5wKolWy35CavLNHBgzb4UEgTmVq7x9QmGRb2wYIwt8sBsVOUCwnS/jse2aAtS
         JuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767612445; x=1768217245;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0rheODQq5/Ix29q4Rp5TwsRkiwe96cL6d5KUR2PhLI=;
        b=PZNNvHukeT6t6pHxDFnhjeSq8Dg1Lt8U+dbvulv6UN/ux5I5R7HB7aAWRCXhvGG+Ie
         F71An4+0TLQ/NC/sG6dFazndmRL6H84B0ShV+2zXiIXdkGC3G343UBWGnMG4dlDQ0ZNv
         2/cT6KQCJYrKIjQNsZRTx/GdS4sin0cHaKBdp+27zQFQLzlCUzhWyayc0V715KvRjrLR
         euWYlxJhnhcaIK7bOOalwdA223b+/5YXYKfV8lWCuicbmGXOPU8LrS14WpvDZvefRq6R
         OET/+9EzfCxgHmEFkxgPbsnPKIGN9p730k+p96KOlzaMYE42du6dmctcWy+xKQeNLkCS
         a/yA==
X-Forwarded-Encrypted: i=1; AJvYcCUHklsSJuFd9jmpbLG3XrbPYHBftIeIyv6yPF8o7cLzD43GBZ+2SmNTmQjZq4hW0ZXFnA2ozpn7tQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzugnuS9PvoxowV2UgMf7qsyieCrKYCFQhwP5VhF/s4/pRO+Xq4
	5wQN2wWRSfn5XC1jEqvnONqV47rnIpaha5s7QXxNLsXYONKcrZz3D7KQ
X-Gm-Gg: AY/fxX4Y2CgbfXy6v9KJDQqhVw5lHFAn/BfV0qWrPlvR37hdSmdhuwliiXhIaASrF7E
	LjzBhVnZYI+3qaXEOkHLbSU0yJp4k8Yyn+oIMlzjqL4QsGmx3XLRJuKfOAta/Wjjtjd8vTgTTbq
	hHZctELoCEn0e4yrjN7Qq3VbJQol6Wh1WzS03se26r9WQQXJe21xLdIpri44Nkkf8NEjfA8SY61
	7XSeXEkcuUlnKlp/iKRnETGDOoatfFIsSf20f+Q0O1rLnTF7q2f/qUyBB7YKfmjgOX6hGZsGGa0
	XObeqoehvfMLpxVpmAK23bzXgfoRFc3yXzo5N7k18I0snCvsKs6MLpVF05aC7pRrIy3Ulz5A3aT
	qpgZeCL4pxosLyFZIEdlfxhw9s13Evm9IJR+dW/Z5jF/ecuE+50iqOAmqSZM5QhWyGqbBZDrWKp
	5cq9U2NvzdQts0islOMlYzvkM=
X-Google-Smtp-Source: AGHT+IGOCrgB98HD0HT6c/uYvFFDqNubQBnKHB+ahKF1w3E0yy3UKIW2NECF/jANW1a6fJaReu1d9w==
X-Received: by 2002:a05:600c:620d:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-47d19549f5dmr616467065e9.10.1767612444714;
        Mon, 05 Jan 2026 03:27:24 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:fc71:3122:e892:1c45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4325d10cc48sm89865134f8f.16.2026.01.05.03.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 03:27:24 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com,  rafael@kernel.org,  kuba@kernel.org,
  davem@davemloft.net,  edumazet@google.com,  pabeni@redhat.com,
  horms@kernel.org,  lenb@kernel.org,  pavel@kernel.org,
  kernel-dev@igalia.com,  linux-pm@vger.kernel.org,
  netdev@vger.kernel.org,  sched-ext@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 6.19 3/4] PM: EM: Change cpus' type from string to
 u64 array in the EM YNL spec
In-Reply-To: <20251225040104.982704-4-changwoo@igalia.com>
Date: Mon, 05 Jan 2026 11:19:37 +0000
Message-ID: <m27btwi9x2.fsf@gmail.com>
References: <20251225040104.982704-1-changwoo@igalia.com>
	<20251225040104.982704-4-changwoo@igalia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Changwoo Min <changwoo@igalia.com> writes:

> Previously, the cpus attribute was a string format which was a "%*pb"
> stringification of a bitmap. That is not very consumable for a UAPI,
> so let=E2=80=99s change it to an u64 array of CPU ids.
>
> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

