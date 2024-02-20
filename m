Return-Path: <linux-pm+bounces-4119-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C82D85BBFA
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 13:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1994D284CCD
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 12:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4106692E0;
	Tue, 20 Feb 2024 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.i=@xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.b="amRESLj8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355585B1F8
	for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431895; cv=none; b=M7UYtPDMUJ9pSl1hDMcwn/qJqqt/ws1uwww6LTE8XuDome6LM3OPMHIe47zAZ2nV8wq6FRUFhb6YyxWEtR35zEJ8tAHVHJR6XCJYONGJ7/uUpydg/fy4L9mAP9ZG0SrPUXH0HyDxtqgL8UllQ5iAcOyjNO2PSBFyny3sTD8OzRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431895; c=relaxed/simple;
	bh=TVQiBYT+JrlpYV7cuvjHyLSeTOYoobY5O5Ut5WaYXaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZ/NdnHbchwSvLyEPKQDnJeMv3FaZ4UOe6d1bQ9llsiGZK4GUYC3b6yDQntHWYw8mDP0Gzav80ED+tr6iz4PpKbSqfvrNFSKpV+RAvp72tGv0CPP7YC5CAkVpFGx7kbL72ObDQsOh1lIvs2SzFbEgu2dM+/+hlzYo/RbYi7kDUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiaomi.corp-partner.google.com; spf=pass smtp.mailfrom=xiaomi.corp-partner.google.com; dkim=pass (2048-bit key) header.d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.i=@xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.b=amRESLj8; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiaomi.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.corp-partner.google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce942efda5so3254604a12.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 04:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1708431893; x=1709036693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVQiBYT+JrlpYV7cuvjHyLSeTOYoobY5O5Ut5WaYXaE=;
        b=amRESLj8zMxlN31hxRhHd+9Jd++sjnp83WpHgffoO6LN6rVZG3fuUnqb73t4WWF1s+
         izKVsqNtdelp2GM779v2Mk1b4hygN58ILYpy6gMg13aw28VdCdrhBfelGzbzJ+rmaIpU
         Te+A49gDidfHqrFLQt03vmW+ZBuBxfSpOQX4ANh7j5snFreGiJcrfCRxiz+eAPwvmgPs
         oo63XX/KwjnhZv1flLxSYRIpWFnctvICMa4uJKou9uS+qovJXhWoLRVyV/tQ7mSWq8qk
         ItYhdCWsNAhMZICTjShogPUb7Dv/PEm/GLoXsOn71nUvVY1NiiBxUS9PWCJUspJfiDYr
         5Odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708431893; x=1709036693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVQiBYT+JrlpYV7cuvjHyLSeTOYoobY5O5Ut5WaYXaE=;
        b=KDs2jygbFyiMyRPPaBe75SYme67KGXbkD0n65ap4jOCBCs99rxGoDUdyXSimgN+OUs
         2OOUFdw0W5roPHoArrMNfCPhj6G99aBNTtWBErVWpAB6NPmZrrTeSKp76Ag64oieRBOg
         IVAmKAoS+P8HE0AHP2n52papPKZS8KzS67BgyU7q5b9LYKJuZnN43hxYZnVj1RO7rRd2
         yHO9uOOrIUSon4kNZwhkXTi/pmM7EcQrWfag2NA0q4CeaeV51rw/O0PgHJ5eEycuJdxa
         wQWb85OTkG85VOvUP4Sn10cISy5ypxOOwxdeg38YVo/vIWMz9qoTMaNkvKfyqM3zDeku
         zfWg==
X-Forwarded-Encrypted: i=1; AJvYcCVICrrZy5gQ/SEyayb0gQVZTmDr1T6vFbxjDQWpqLD+JX7+2pYSALqISR/YCpC6SLszRrvoTdPCH3B+q7lbX2RU0Y4T8gUsIrQ=
X-Gm-Message-State: AOJu0Yx9XKQQMTd5s9Luzkq6LdVauvkBeG0021Xxa+vw6lIB4gri+uQ4
	9aVNu/wEUC5vI7ByRbt7Njqp3VaKkAamXmHSJwGijakDYuy+aSuQ7WM7BVo2j/s=
X-Google-Smtp-Source: AGHT+IHNbmsRe4qn7Jfphg6HGNrYIWzIH1y+8KCtydVknWjsIcmUd5fJERQ7E5EIfmH4rgwmgAEXSQ==
X-Received: by 2002:a05:6a21:9209:b0:19e:c2b2:ac50 with SMTP id tl9-20020a056a21920900b0019ec2b2ac50mr19479366pzb.12.1708431893538;
        Tue, 20 Feb 2024 04:24:53 -0800 (PST)
Received: from xuyingfeng-OptiPlex-7080.mioffice.cn ([2408:8607:1b00:8:b27b:25ff:fe2a:187f])
        by smtp.gmail.com with ESMTPSA id lx14-20020a17090b4b0e00b00299f727f7a5sm719174pjb.46.2024.02.20.04.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 04:24:53 -0800 (PST)
From: Rumeng Wang <wangrumeng@xiaomi.corp-partner.google.com>
To: djakov@kernel.org
Cc: fengqi@xiaomi.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	tkjos@google.com,
	wangrumeng@xiaomi.corp-partner.google.com,
	xuyingfeng@xiaomi.com
Subject: [PATCH] interconnect:Replace mutex with rt_mutex for icc_bw_lock
Date: Tue, 20 Feb 2024 20:24:47 +0800
Message-ID: <20240220122447.32261-1-wangrumeng@xiaomi.corp-partner.google.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <4c3f9f52-cd56-4d20-a44d-bfca0b2e3b7e@kernel.org>
References: <4c3f9f52-cd56-4d20-a44d-bfca0b2e3b7e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for your reply.
The modification you mentioned is a modification made by Qualcomm in 2022 to address the issue of icc_set_bw, which involves changing the icc_lock from mutex to rt_mutex.
However, this modification has not been introduced into the new version as it has been upgraded over the years. Therefore, there is still an issue with icc_set_bw on Android U.
My modification this time is to change the icc_bw_lock from mutex to rt_mutex, only modifying the icc_bw_lock without modifying the icc_lock, in order to reduce the scope of impact.
Here are the reasons for the modification:
We execute test scripts on Xiaomi phones. Each test will have 5 rounds, and each round of testing will involve continuously entering and exiting 30 applications. Every time an application enters or exits, it will grab a trace to count the frame loss situation.
We tested it four times using the Google solution, which is icc_set_bw use mutex.
Every time the test is conducted, there will be frame loss caused by the icc_set_bw D state issue.
The recurrence probability of the iccset_bw D state problem is 5/600
We tested it three times using the Xiaomi solution, which is icc_set_bw use rt_mutex.
Every time there is a test, even if there is a frame loss, it is not caused by the icc_set_bw D state issue.
The recurrence probability of the iccset_bw D state problem is 0/450
Of course, the above tests still have their limitations, as they only tested the application in and out scenarios, without testing any other scenarios. However, based on the current results, modifying mutex to rt_mutex has a significant optimization effect on frame loss.

