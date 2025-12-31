Return-Path: <linux-pm+bounces-40105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F07BCEC5F4
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 18:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62BDE3009814
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 17:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B712BD015;
	Wed, 31 Dec 2025 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvHMbRdn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303F62BCF4C
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201848; cv=none; b=FlWFQ83CDfAaVo/60mm5ZN99uQHOdhtKxfds+JKPD+pgP61UicfeRy0i05jH6HlAD+k9G0jJ05p9CurnXSqPsD+K9PjhAFVu0vLSjlhooUbMVXul7JT7k/8ev82mHRZabTKAny95+vyHOW6ugHpZ54I5kpBkQlAnqkwOo1+Mw8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201848; c=relaxed/simple;
	bh=T8Y8ubirw01g5zFTgijalKE+TvYZvn9mJqyF6t4G8Q0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=pR7BlTeD+3PkwHQ12SpVy/DizTNRVgTK95dhtlGVZenG5Fu0KH/JewWKkbsxFBfmrXoIm9urUffys0ue2UhieHzkrcWj0Ol5ytkC6FjIYUMu7Kuwxoy25EaocUVtGMagIFhlSjrRRTo0EKY1kuOYSFl+xRbFyI3aRUNoEWrDmKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvHMbRdn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so84324585e9.2
        for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 09:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767201845; x=1767806645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R87JjGL/7Tv48x8Fv9GR/wm2jySKUeW5S5Ujq2orAxo=;
        b=fvHMbRdncJb0qt1wtIkCCaL+CH9x42WKRTOucUJAwnS+tQFZudByY1Fgo5lOIojsVA
         EO0V7FObw7hu53c7jU53AwBy9+6ohb7jNAz7Ggr5UyKA3LDk8iqqdl1PWvllC45hTVe/
         YszwcomHqDZemUv7dXOLhC9ZUHycUch4VITv9I8G7SOybhyrPZ8XJy6Dh68X/yZNgXZo
         VJY5qEoxoTfmTN17l199TxDeLRYSU11tihQtJueQYLvw4QYK/B18vVUeAPpJx4vAFf0o
         UzYqymKgJwTCkI2e1a1N2j7N7SzwlkdswliGkz8TZniaBD7bDkF0130BjkTSA4KXsERL
         ELWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767201845; x=1767806645;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R87JjGL/7Tv48x8Fv9GR/wm2jySKUeW5S5Ujq2orAxo=;
        b=gVbpju8W3/hu3Xn7R1q5l6jbZViwOJibFM+tr7LekXimmScThtGsNPdCCO7NlGMKA/
         WTIAraTgjkJ7rUB+i9z2K935EwzaMN0uEYn54gzcv0gp6uNzYtyNF4M0XQluiXVjWfjq
         0cxJjzAkheTQdlP4MNmL8x26P4em56eJIUG2xWqbjamuvrESg0poQjzhVJI9TWMrV4w4
         TuKO38mqAXvaHYfe/XH4dsSWv+7t5kw0eN8blYVsk/ziAwS3uQMYa/iKuWJ94zHLeuSx
         VyoOraY0k7BUefpzBeiQm35094pwxDLYl1mkERpp3oTsitYpE6fQvQPDRJQNpDAFDjrX
         U/Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWKa0T96zCWiATUmloZV9gCLEVp6KmkSXkOSeH2ucg4T3yhlS1+1I2QXQwARTs/owKQE1tOyCHzRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAZ3/OXnvuXIfliHN9M9lSQcPl6BwnOUhTz8Ox/BNQP2rFV6oX
	vlulgA8ULDm/7IcSkPFbGl5BQyjluqYVP1hkDAtmkxqwkv5L4T6oaLBW
X-Gm-Gg: AY/fxX6Jyi1ZfyEDso6n20ToKmwy0xdSU1/W9wDCDb7W+MYSyJrvQN+jAGrdkw7LMeM
	zvAg0sIdfO75lqnGbcCpCtBT0q9Zc2lCSIT7EoADlLe4RhuoEH+zhVtOFSnrwcqmjNR5DvCckCy
	s/zlgIPBTQ4BFXxrUIjHlU0HRIp9ISCdrwYYRsEMDp0lPbAr2I40UBcqNzUHQCVWZbfQLr4ka/x
	oWQEvdtXOiP/6do0lHiLPz92YwoNfK++GYaXWT2BPgpCbjBzfppTzbmZNf74CaifVAyaaVpqoQh
	6+/80C5Bvr4Gw78efRWH8jI4o4zKA6rSJ7we2coL+EWFJTPhOKfZ+NrEUmALwvlzX7LbaMFm9ye
	j/dvV6kTyxhq303ZGGmK8uuFpCqVxB5KkaBnHPrkDgIW4dbbnzEf0iaWDmu8qSXjDhhWZ2N7RDq
	TXm199f6pHGnnmzpzzcpSNC/23eTsPPIS/
X-Google-Smtp-Source: AGHT+IFdVUAusCYbhXtGHx5jk/mS7YxbHvH2ZdgmHlBVw+Es8g6zXJWrYIKrmmgwqUnSvZCNAmfSKA==
X-Received: by 2002:a05:600c:1912:b0:477:89d5:fdac with SMTP id 5b1f17b1804b1-47d1959f714mr510979675e9.31.1767201845337;
        Wed, 31 Dec 2025 09:24:05 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:2944:18df:f54a:f00])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af2bsm75005716f8f.1.2025.12.31.09.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:24:04 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com,  rafael@kernel.org,  kuba@kernel.org,
  davem@davemloft.net,  edumazet@google.com,  pabeni@redhat.com,
  horms@kernel.org,  lenb@kernel.org,  pavel@kernel.org,
  kernel-dev@igalia.com,  linux-pm@vger.kernel.org,
  netdev@vger.kernel.org,  sched-ext@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 6.19 1/4] PM: EM: Fix yamllint warnings in the EM
 YNL spec
In-Reply-To: <20251225040104.982704-2-changwoo@igalia.com>
Date: Wed, 31 Dec 2025 17:20:21 +0000
Message-ID: <m2v7hmk1pm.fsf@gmail.com>
References: <20251225040104.982704-1-changwoo@igalia.com>
	<20251225040104.982704-2-changwoo@igalia.com>
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

> The energy model YNL spec has the following two warnings
> when checking with yamlint:
>
>  3:1    warning missing document start "---"  (document-start)
>  107:13 error   wrong indentation: expected 10 but found 12  (indentation)
>
> So let=E2=80=99s fix whose lint warnings.
>
> Fixes: bd26631ccdfd ("PM: EM: Add em.yaml and autogen files")
> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

