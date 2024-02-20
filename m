Return-Path: <linux-pm+bounces-4118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2112385BBDF
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 13:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D177328127E
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 12:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129B567E7B;
	Tue, 20 Feb 2024 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.i=@xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.b="ATGfQp1j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AB767E70
	for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431711; cv=none; b=L90c0nEbdawD4lC3aCylO3ILU53fOZvmLu9+Jqte/bc3uyGst7kkAoQkY0VXYAJBkWYzrdvpLqeANtYG+iCMJFWFCUBoDygBzFaBqeaiIZ1neazw7qU3HcMpd9cQs3Y5CAsAxm4XH2BEc4k/OjDRHffQVhYCDNWXhp1iI6hacCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431711; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEvKtdJ033WgpFXRN/EMs3YmrgngP88PqapBGnHpfVYej084ixjphBPQs7ahk9M9LXItRc1tGxpytBYMMguGW6u6LkTBNrYsRYoXWjAQKaj/ESsxQpeo+rwLQBUeN4RNgL0DXlM7rqmBfUoy0QUdUDpNiVsNRNajQWvW+XNg0/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiaomi.corp-partner.google.com; spf=pass smtp.mailfrom=xiaomi.corp-partner.google.com; dkim=pass (2048-bit key) header.d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.i=@xiaomi-corp-partner-google-com.20230601.gappssmtp.com header.b=ATGfQp1j; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xiaomi.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.corp-partner.google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d95d67ff45so39429135ad.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 04:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xiaomi-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1708431709; x=1709036509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=ATGfQp1j6nsUaPADra405TggI8fCauqshIeoa5E6g8nm0ML5gBfaA0gv06cGxK/taC
         oVii/JW4C7JSQwua2mVtnnv8mBJWO8ou+eKCz2IXplnu97gfurH9A49H4theq3osd8uz
         noGnuIZq7nUL1OSvScN1GQxjTE60+Z3DYlobElpimSiXbvvmBnm1oegnGCU1CCUf992P
         uU2zCUxnhKARPW+gN/qzEjGszHWRV276W9ZsRqbIKM77Xe7QDE3Zpy82d6QoXh2TxFo0
         XyzehuXIBbKOleDTF4JtpCxUd+RY70X0LFkmb/OrNVAWUPZvdX3FP2+8RIWbAKJfEXZP
         Pmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708431709; x=1709036509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=q5CTeET7rsZMRPXcXHWxgLENKkZV105V/o2ZrueD/AqpCSPJF2olmXsxmLqmpbPx0L
         2kk/G3l1z9ZY7G8IrdQRkrdGL3fRzSLW8aZfA7YxuiJStD0iIgqG0hgJ8CDwEw2vqQZF
         Nh2QYebn5++MZdnk4Z+qbMqMy3bGtpRVAkxE28IHepFUtWAb0yfhunRtxN0/RGYb/B3V
         fBvd8YpNvpJ/qQ0rxPH59F/ZmdM8CvBZTsmcANT9s8VrFewC63gM7x43YOtcyfyu3Oj3
         RyNgfRJ+piZtJN4CangxlZymGvZTYAeabbzkU1OKDRQvqCY+TH1PHFtb2qZCLgntZ/7Z
         G5Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXxtNlWVlFGx5JdCIaIV3xKcl529x9o67hW3JH+briO2BKY6QfDtqOmmbfCI/wTEGR5STtNza/FDBnRi11PQj/5yWe8aSftEoo=
X-Gm-Message-State: AOJu0Ywo7mwKONOOxi5ux9a3xLu0t0QVq4Vvv4I2oediPZYj1t2VCVhJ
	7+W5Uzv1kMDzIDiyxG6/2lxSRosTKmlGTNf7EKgxmPOYptXXJ6gtMrB8IoVQIHAwBNdX0p85p7w
	D
X-Google-Smtp-Source: AGHT+IGmprxaQeCnOL0HyVU03s58a9g8YZAdjSMv67qLw4iHHXYIvZxZaL+4+8SK0zS+ItVOCov8aQ==
X-Received: by 2002:a17:902:d503:b0:1db:e6f6:e28e with SMTP id b3-20020a170902d50300b001dbe6f6e28emr8004991plg.38.1708431708947;
        Tue, 20 Feb 2024 04:21:48 -0800 (PST)
Received: from xuyingfeng-OptiPlex-7080.mioffice.cn ([2408:8607:1b00:8:b27b:25ff:fe2a:187f])
        by smtp.gmail.com with ESMTPSA id lw8-20020a1709032ac800b001d54b763995sm6104213plb.129.2024.02.20.04.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 04:21:48 -0800 (PST)
From: Rumeng Wang <wangrumeng@xiaomi.corp-partner.google.com>
To: djakov@kernel.org
Cc: fengqi@xiaomi.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	tkjos@google.com,
	wangrumeng@xiaomi.corp-partner.google.com,
	xuyingfeng@xiaomi.com
Subject: [PATCH] interconnect:Replace mutex with rt_mutex for icc_bw_lock
Date: Tue, 20 Feb 2024 20:21:42 +0800
Message-ID: <20240220122142.31756-1-wangrumeng@xiaomi.corp-partner.google.com>
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


