Return-Path: <linux-pm+bounces-13841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA25C9702FE
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 17:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A6B6B21881
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2024 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F356D15EFA0;
	Sat,  7 Sep 2024 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM43w0MD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9573A1591E0;
	Sat,  7 Sep 2024 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725723781; cv=none; b=CHxGTo7zOzbKvitecZg1Ka7/M+dPPkjegpjsmnfRE9tD9RIeTGmvoJuHUBUIwWmasblBwUvQGLICTP+98nir5MAg/amNtUjzQwg4Bywo21rfRegFRYSI/bx7W3LyPUGmPr5qEkRgvmSEIv2CVx+Kxemky///o9qK3cnLl5qH68E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725723781; c=relaxed/simple;
	bh=Sm+rgyd9zv/hqvUe/8YRfKp1YDQm16uTNrMhxVvTFK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMmfPvLN2ZmGO4VVqsuYHqJYcOslpxkwcNzFtKEkgnrAAzuYa6T7wORFYT/4bvaGtHyo/OteN434MpY2G4wyv9+8X2JdplKromV1RPDvBKmMGTvxApoMK9k5gJzsRiYgnqyuqq0YH9a9wrgg6rAOFeM5ryehu429oaS4hKuVAG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hM43w0MD; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d4f9e39c55so2133112a12.2;
        Sat, 07 Sep 2024 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725723780; x=1726328580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHL61UNl0PE9rcFIUgRmEpCiRnTHikV3tbHNl+5vifI=;
        b=hM43w0MDBe3b+/XMTzbMaB/gpksZ/YNLy8uRxKjUpz89hh4JaZKi8cHjaVqVq/6D3R
         eKdhsBJHQm5sVgaU1LJ0qjDP/PQH6PfKhs80oSVS4Y8yDKKN8hwF1hawqJ4rEbtWbyqE
         AaEmXVci2Gzuf5hQSapQVjfoct6m61BNcZYrWBw7suD9SrDOHvFAhRIS0zdDP/dN18cO
         R+usxYn5PZFE2ahZvCURqCfz2U5FWZ5KPmUJhcVsrKNDIDLLXRRN9K/4obyCYotNlFY8
         /TVSPRiFY1sLDKURgT8207J4SxoYCdLs6xezZwargHdOfmcwUiezHSfV2dNKsRAkKF01
         zTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725723780; x=1726328580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHL61UNl0PE9rcFIUgRmEpCiRnTHikV3tbHNl+5vifI=;
        b=E6cwRnNpvVFAMUlOwFao21In/r39L9RCbnemcntDOR4J6U8GfvR9vDs/kIQgUTpFYW
         OkU7hYID5GyW41F2StCvzZMf1zRF1WqWnoV3kZQDJPMs7YFGPt6vryIzidMyXAYNppiX
         Ca1/ShJvzAQ9hWKFVtqP+C4alPnqkkVC4/dQDQsU4IUCBSO1J2i4dzO00ayaqB9WEaUs
         Rm19PeDDIYo5jU6W4YuWz6ZGXNqPrnrEfKC/yDkBTCG1lRNRmWJ6ZJoVppHRmnr3eN7q
         uJjrdwFnvnwaAdVErmk6jIPc9UjNqIdrorPxCU4hfyN45N2H4+/DdJUIjZCYT33z/pY/
         cATA==
X-Forwarded-Encrypted: i=1; AJvYcCWqFRyxorv7C20yNu8QRdnaECsLYxfoBRTIkitQRKsiGms8Z+am5ZtefHsBH1X2X+RaZsdLyVbP6Jppkvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr8hfd+Vk4sf80t0+eFknr0CKI9PJjD+9aGypt+eKznBurX90q
	ZWra/siKpp+I1d6AyO8kVIRTHsDBYULC3v39xQ+1v5RxtTwwoPsM
X-Google-Smtp-Source: AGHT+IGC+zwd/vodOVDir/lP0ykmfQaHbTnT7hfJAadEscELYS2F5RPd6K3fkIdrCP83hx1IBH+WLQ==
X-Received: by 2002:a17:90b:3696:b0:2d3:dca0:89b7 with SMTP id 98e67ed59e1d1-2daffa3a9d4mr2972439a91.3.1725723779763;
        Sat, 07 Sep 2024 08:42:59 -0700 (PDT)
Received: from fedora.. ([106.219.163.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db033fea14sm1417024a91.0.2024.09.07.08.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 08:42:59 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: Markus.Elfring@web.de,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: mediatek-hw: Fix resource management and error handling in mtk_cpu_resources_init()
Date: Sat,  7 Sep 2024 21:12:49 +0530
Message-ID: <20240907154254.4704-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <c1e8c2f1-d123-4e72-a774-f15daa156afb@web.de>
References: <c1e8c2f1-d123-4e72-a774-f15daa156afb@web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> Memory region and IO memory were not released if mtk_cpu_create_freq_table() failed.
>> Added error handling to ensure that IO memory is unmapped and the memory region is
>> released properly to prevent resource leaks and ensure all resources are cleaned up on error.
>
> * Would you like to improve such a change description another bit

Should I elaborate a little more on the issue and explain the fix I have created?

>  also according to other line length preferences?

Can you please help me a little bit about this? Is it the character lenght of subject?
should I change it to: cpufreq: mediatek: Fix resource leaks on mtk_cpu_create_freq_table() 
failure.

> * How do you think about to add any tags (like "Fixes" and "Cc") accordingly?

Should I change "patch" in subject to "Fixes" or add commit id in the patch message with 
fixes tag? Also, whom should add I in cc since I can't find any other email from get_maintainer 
script.

Regards,
Riyan Dhiman

