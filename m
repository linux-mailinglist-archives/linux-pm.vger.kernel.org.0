Return-Path: <linux-pm+bounces-13983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14874974B83
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 09:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31771F27B1D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 07:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFFB1442E3;
	Wed, 11 Sep 2024 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CRmjnZJk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E71B13D26B
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040096; cv=none; b=ZQ2HrJkD3+KFPrnbVk44BmhGCgydkBnedD4lG5rN8t8eCcsQfyzHcMCozSA44wOYT9abno1oquNYwGJY89t//RL7V+K/haYVpDUsNmrS3I5oSVS5LZXb2LNWAr8mBhJVXMBl+sN3s//0gFU6Pkrj2kmjN31V/EkSD0DrIzrCiDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040096; c=relaxed/simple;
	bh=yJYSLHPhIpsOWTuLVPuI4OyVRB2m6wnHAj5BQJb3wks=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EhQlurMtceAbbN+noXlezKiZpn9R3fh9yAyJiIcaUDrEv0QS7waLUZFmhK4uXkZSdhzyKgjfVeernvRQ6bdQvU+M/nl5Aaxis/1iHOm4XSpovUfX0/qhoNdPlXCQI4/8XSWZm1xG/gdFHWeNXDXc+clL3JwBHHoXODOGRJrkPI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CRmjnZJk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso37984345e9.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 00:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726040093; x=1726644893; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wKhoG9fBZaRiZRjh6iJJjrGOMArJHWjvPAgovxvapjU=;
        b=CRmjnZJkhOp2G4Mun1dvegAW/3ualE23FiOHx5FUEFRQH5Ee2kSTRJRd29B0r2viXp
         CIf8hBMHxy699FfO47KlJx0dn+n6dd4f2/KL1gMNbl1mC5RC8c6+H+TmIByep+JYkOP0
         hXqpzWm7YZckyrEbe42EUd8RG05WRbUqAEHzUwMX/oIrmHAis/T6ZM7bWC+t8AhMFK/3
         cnOQZIWJLPJhS85DLIKVxSm84P6vpTvJhQDhbSNICjR3RGmWSJ7EOqjjt3RMF+AruUV2
         JU7m8Clqzp+U4fM1URA2RmT7qQQFr34DJKNaCfsp1118YCPxeZ5EpwNgRx2NPVzfzxM5
         L/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726040093; x=1726644893;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wKhoG9fBZaRiZRjh6iJJjrGOMArJHWjvPAgovxvapjU=;
        b=tQK/kpGTw52B68BpUbqqfcdbdRpBnHAOGNvTgFQPC2+SRibKvvt7nCHVtOTxF7F+kQ
         S16QmpNUwrG31xjeLJUqzRJZ2jt5LMCVlB8PkwJ8C2LGi/HQTjsV19rzy4+niFXvFe0V
         RixTRuqkAH4KkurbaP1/9gaVk2vBGIxQKqGq7xsWAi5mMmS+mHq+pR4PgihrEHGDZXvZ
         r6WUtbxZzxgmjY8ER+4ZUyOnkz/cl3cDxvGaRvemEEPZIIdgy96b4315Vs2ZBmXO37JJ
         Bk3cFkcVRD/ZEvJ/B8LOwr28M/UuVaHSc7ja685oEAx1iE+0ySujND4ga5g/mPY6VdAH
         o77A==
X-Gm-Message-State: AOJu0YyOqa/u7bLdvq6aUYO3haGs18w8pAIFCIyVzxW9eLx/y3Yum/a4
	d8hHWN94fCHWKzgHCevQ6fG28KRJXVLXmd8B3yNb/Y9SVRc87Mp9NBRWWLrP4Hs=
X-Google-Smtp-Source: AGHT+IFpGCj0Tw5zkjwOEi1XWHI6pzbgbVe292Ahnngwx+HF0oYboeu1oE/5oSKH86ItadSsdbuKHA==
X-Received: by 2002:a05:600c:1d14:b0:42c:a802:a8cb with SMTP id 5b1f17b1804b1-42cad760f2amr107178635e9.15.1726040092636;
        Wed, 11 Sep 2024 00:34:52 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb0642f99sm131498675e9.40.2024.09.11.00.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:34:52 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:34:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org
Subject: [bug report] cpufreq/amd-pstate-ut: Add test case for mode switches
Message-ID: <5cdbf27a-1baa-440f-a943-d2aaeec99b38@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Mario Limonciello,

Commit e121c01c0422 ("cpufreq/amd-pstate-ut: Add test case for mode
switches") from Aug 31, 2024 (linux-next), leads to the following
Smatch static checker warning:

	drivers/cpufreq/amd-pstate-ut.c:290 amd_pstate_ut_check_driver()
	error: uninitialized symbol 'mode2'.

drivers/cpufreq/amd-pstate-ut.c
    271 static void amd_pstate_ut_check_driver(u32 index)
    272 {
    273         enum amd_pstate_mode mode1, mode2;
    274         int ret;
    275 
    276         for (mode1 = AMD_PSTATE_DISABLE; mode1 < AMD_PSTATE_MAX; mode1++) {
    277                 ret = amd_pstate_set_mode(mode1);
    278                 if (ret)
    279                         goto out;
    280                 for (mode2 = AMD_PSTATE_DISABLE; mode2 < AMD_PSTATE_MAX; mode2++) {
    281                         if (mode1 == mode2)
    282                                 continue;
    283                         ret = amd_pstate_set_mode(mode2);
    284                         if (ret)
    285                                 goto out;
    286                 }
    287         }
    288 out:
    289         if (ret)
--> 290                 pr_warn("%s: failed to update status for %s->%s: %d\n", __func__,
    291                         amd_pstate_get_mode_string(mode1),
    292                         amd_pstate_get_mode_string(mode2), ret);

mode2 isn't initialized if amd_pstate_set_mode() fails on the first iteration.

    293 
    294         amd_pstate_ut_cases[index].result = ret ?
    295                                             AMD_PSTATE_UT_RESULT_FAIL :
    296                                             AMD_PSTATE_UT_RESULT_PASS;
    297 }

regards,
dan carpenter

