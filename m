Return-Path: <linux-pm+bounces-8166-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412548D0082
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 14:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F52A1C22627
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 12:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CAA15E5BE;
	Mon, 27 May 2024 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="li6BJVxB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A54615575E
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814564; cv=none; b=OMNYvWFBvGgTvtkGBn0y5yqRzAS83yy/AY3pu7cjJ43dm62jikNQhcq1yTYGth14t/2UGFygi5r3xR/ba3u7+gujlWzQIJqe4Mj58/McQ4fNT0M+glGuZG4YSaoRh/D8LFETWbDhM+L8s1/416RmsyS8YTrKkC1/IDnTynAbscY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814564; c=relaxed/simple;
	bh=uHoQyqtfs9aedfl3FZUFqI5oP0xkN2ZZKZ71WyCP/jw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=VP/m7A5o5udrTiU2rAZ9xK1aMh+H75+D1+CSPrBH41qhMA0Y1ORmOcc/BtTbX/10sKtX0xNE8ATCfnqJuDKwLLOV75jCA2ghbGXsEUn6Jadu5vbLbR6Qp6Pz723RxsTzqo+Myhn2SvOiaTfOSJUUJR2IRyCtI7bZFkRxK/CgJXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=li6BJVxB; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-354fb2d8f51so3231431f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 05:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716814561; x=1717419361; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xai3+DoRd3KhmrE/O0pqUWQXYebgeNKiH5+Jp5lvG7k=;
        b=li6BJVxBT6KOXCaZwi+oiKPmteoYnSN/UtANMdNfZBBoYDWmPu/c/x20jcucfH36c2
         GJpYkO2xggCX4QiITOHVGhti7umCRhXYh/x4SRW6b3AVgo88cmHkS4aP+03qPN3FA0oe
         zwxL2JyP1OI62HSvilIGzCZXg35NNo3c1IxiqOSfRbtDqC17t5i72KP8Vo1Rf5jcgTjl
         jz79qT42IBih6636AXPrJkK/0knKIkMtZn18VQkGvBITv62IO8HEPE9sWtwUSliAkLcD
         irVA+1zvrhz+AecVQYZ537dRDBgweL9y9fuQpMmwHrQV0G43Xb8/fTcZwi4JSqyovPEC
         yQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716814561; x=1717419361;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xai3+DoRd3KhmrE/O0pqUWQXYebgeNKiH5+Jp5lvG7k=;
        b=LX0D40kLHfe3P9lI/+ZggLpAuAqwXutSM25tTNrkVkTcTZs9sP1gF3VsF2zdznSbfQ
         xZy38qymTwQlmb4xw6BXfGK7hGYRR9zrZ77bQG+01MvMPlgPjFk2g1lvBAc5QTSVNWfL
         VAPGYAVIQJGG39MIpW2h0dyJm2+tsSxAbd0pL37NpHVf+c+ypUfEbDth3bQo60G6sF11
         imRUZjincFZ8CPEITto51QLeKFJSfaXvwLnn/xCXuT3N6el0Mct7UhU0QssTCoNJH/fM
         THhoZJwtyRbR7sdK2AuD5WlLGLUHx1DZWol+uexHvMROniPV8I2RP9CGvSwZ+0Z54cIx
         ASZQ==
X-Gm-Message-State: AOJu0YyzBoi1gDs5X+KqYSY1kncoKmr7hO22Q8piT5xRkzvyng4X9VL2
	kBPKmt1qMvrPt54ACqkUBlRMV24DpUkdoguQU11RldXI4OF3HowfuhGoCX53GcQ=
X-Google-Smtp-Source: AGHT+IFycL4ZtUIP3Kt44MJDT46JYVd1or7jNWDXFDR/yiu0EucrdecIai2/3GmybzeawbLyH/NvtQ==
X-Received: by 2002:adf:e589:0:b0:34d:b40e:79cd with SMTP id ffacd0b85a97d-3552fdc0aa5mr6374269f8f.42.1716814560529;
        Mon, 27 May 2024 05:56:00 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35671d03330sm7562108f8f.64.2024.05.27.05.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 05:56:00 -0700 (PDT)
Message-ID: <59e5a949-ef20-4f11-a0a7-247c457f1dd3@linaro.org>
Date: Mon, 27 May 2024 14:55:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: powercap ABI clarification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Srinivas,

the powercap ABI exports some constraint files. Even if I suspect their 
semantic it is not really clear how they should behave.

       │   ├──constraint_0_name
       │   ├──constraint_0_power_limit_uw
       │   ├──constraint_0_time_window_us
       │   ├──constraint_1_name
       │   ├──constraint_1_power_limit_uw
       │   ├──constraint_1_time_window_us

Are the constraints controller specific? I mean, each controller defines 
their constraints? Or is it supposed to behave the same way whatever the 
controller?

Is the time window giving the duration of the power_limit_uw constraint? 
Or is it an average power during this time window?

What is the purpose of min|max_time_window_us?

Can we set several constraints or are they mutually exclusive?

Is there any documentation describing with more details the ABIs?

Thanks in advance

   -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

