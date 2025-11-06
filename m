Return-Path: <linux-pm+bounces-37561-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85638C3D49A
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 20:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4035E3BF0D9
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 19:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228702C0F67;
	Thu,  6 Nov 2025 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4JGvknu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756A5184
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762458891; cv=none; b=RexqkawsJAR5XmwjX1k4Jt3BBpUEWlOZoc9zRgZf0u3UK6u8f5CF7I2qMNtZTvVmGFZPmI80m9ZsQlwDByoHTDt3YlduIHqzUEzN2zZcM0uVX8uFyETrTrdMi+TaMRBTCDJjZqKUR6Ghda3PSNPlSxBIbGO0Oo7g1B9LGuJCs1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762458891; c=relaxed/simple;
	bh=hoASztyN7zM5qQG73EHJyaR+LTuYhHZn+vpGaqNYJ8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVhhO41YiXO1NXs8NvtSLxYyRsRSLe7FaT6DPYMsXOMcgSaYbzIIqUV4+OKY6H73dBNkjWAzeazY70+JDRY52avpnZhPk++4f6KA1BfliwMMa29LJ7+7JH6CYPfRKxdX1hu4GWBwBbVEhHIMQzsLBqwhTL9qZg6gpZcMxEs1BfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4JGvknu; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4283be7df63so3354f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 11:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762458888; x=1763063688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UncuczOWw6dokilvcuzPn40rJVCGU5bE5RCqhJ/ZTg=;
        b=A4JGvknu1QcH0R3S/cCSgTziOiwBJwNi/8Y0cmXq+KKBSGgmqhRaPhuOV8BUOXI2wS
         R+h3sRbkCcuSJumyIgN949NUqJnavEVga8mNvmraoFQWVqpGDcgVvcGJSFTHyV75hIi2
         0eaCMKvHsLwMjvEW8cLyKinrXeXzD2B1FCmElbWQ5EsDbWzRO/p/6A90BYQxJnPHiypT
         /FPEgDBxk2Gb7xebo55aW2E7lqc0Em2pqAUmLR4jjqqv7KwBSImKFMVQFJi2ci+PX1QN
         gGA+fgCyPKfLGUMLUny6I1an/r/Js9UHgRhIyk9pcng0O1EEbmvIGiz3S3AqXrEdXy+r
         sybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762458888; x=1763063688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2UncuczOWw6dokilvcuzPn40rJVCGU5bE5RCqhJ/ZTg=;
        b=hzlrazEHmHNY/+dA06kT1uDoufkiJ3Bw5TT9Bu/IaZnnItHCkx3GdJUaDnbaFPrkti
         NveWZdgBJe9W/ECUpJeSJz1xzvCuHEp5fhahYQJnDVbckVG69JFHh4htovHatPrWYAO1
         2b1PZsrZ2/3ugUW0kzW54M7PM+GNplev2TXJSFCD3SwBsKofSctlmV2EbTcP25ntF83x
         cb2NRm2IojHmQyJcoMiAi4fjIYbDgxkDi/0WdKVEVI7x3dF7pPc1vMlcagdeUGAXdw9R
         rrcb2UMN4s4+JnB2xSb2W8dnJA87QRNVmb5V41EfUylld2jFek+fLc4lRqJZrx93BucX
         EnDA==
X-Forwarded-Encrypted: i=1; AJvYcCUbCOr0O7RxD9IPwgd7js9FUhzyCls4UU6cmiU7r1352cC/vcvE62ARIdAPr9Om5Ubos6uBFyz4Lw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb8+GWhetX587KrFre+OaMiUxSAM2pvTFQmRBcSWlywLpwhBYL
	mFi2FfWQZsIIVnuOYwKKwImROSp8oNid9eRahhc7/DJD3NR3+cndK2oi
X-Gm-Gg: ASbGncvX+IPDygXrFc1W6e03FB00H781MiqyA5dp/psrQlH2CgQKX44/n1sIkbT38VU
	0FfP6S3zA0kKJC5XPRqKnvvDkKLSmim27IzgHyG4RmG9CSOuBX3nFU2BA8zShtyEcxR+9dWYZua
	bYnOJbWuJK9Om6AgYT8q4f6OpIG2WpEYReozXVHaraNkgiKxExirTRZlHOnzf0uD5c8u+vTjA+K
	fzxD1q44UYj6dOwUkkFfoVJ3bj8EVbsUNZPbJY+7Gcl5wFPYQ+mUr17rI+1ROHcJ1jGgGUAtgG0
	SMTbCUWysUHAioBKxRnvBs80lFfzw0l6eobCXrrTpCov/s6nIrJC4/6h41EgyUcDm7dm+LHFf+b
	+rgxY2aZby6IrhQM75K6zXDn+WxH1IZWQ3uoKebLQwEWtxX358yDZCea2MPXN4RdR3LoyUKkg
X-Google-Smtp-Source: AGHT+IE/Zu2Ru0LpFrpPNUWpT7s4DV8LxLL5QMc5C+mR2Hxi7apvhG0xIEItjNgI8p2cly2Rw3KseA==
X-Received: by 2002:a5d:5f51:0:b0:429:8b01:c08d with SMTP id ffacd0b85a97d-42ae5ac38eamr441307f8f.41.1762458887528;
        Thu, 06 Nov 2025 11:54:47 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42abe62b1e3sm922480f8f.4.2025.11.06.11.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 11:54:47 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: superm1@kernel.org
Cc: lenb@kernel.org,
	linux-pm@vger.kernel.org,
	mario.limonciello@amd.com,
	pavel@kernel.org,
	rafael@kernel.org,
	safinaskar@gmail.com
Subject: Re: [PATCH 1/3] PM: hibernate: Emit an error when image writing fails
Date: Thu,  6 Nov 2025 22:54:38 +0300
Message-ID: <20251106195438.7622-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251106045158.3198061-2-superm1@kernel.org>
References: <20251106045158.3198061-2-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Mario Limonciello (AMD)" <superm1@kernel.org>:
> If image writing fails a return code is passed up to the caller but
> none of the callers log anything to the log and so the only record
> of it is the return code that userspace gets.

Thank you! This is bug fix, so, please, add to this particular commit:

> Cc: <stable@vger.kernel.org>
> Fixes: a06c6f5d3cc9 ("PM: hibernate: Move to crypto APIs for LZO compression")

a06c6f5d3cc9 introduced that pr_info("Image size after compression...")

-- 
Askar Safin

