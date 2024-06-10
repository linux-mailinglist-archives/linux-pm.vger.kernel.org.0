Return-Path: <linux-pm+bounces-8876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055BC90234B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 16:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032AF1C2208B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 14:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC311459E3;
	Mon, 10 Jun 2024 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N1fIm3Xf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A4913F439
	for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718027698; cv=none; b=hXRnHaJi8qhDlXCRAzmy9NXozVpjXQ5bDNJjNRd5nAdtGv7Wwcze7btbxv1cFtGC454Uc5UipluoO8uIA8I7QCrYAPxgpTNaHkg7XcqXBV2wDDCIhIFR9cTjzwA6KekrK6x/d171RtoBX2hgHSQYT1TRLY5xysH7Rt1IdYQqiJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718027698; c=relaxed/simple;
	bh=ki43rmTAZ2DSDh0LcmlMo01yj3pL0uFTjHOQnIDSoMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOichNQ8MkoeJ6eLSE7ckXL00WzxnxILKuc7N3z/YGvob5xjQXTX/EUn45dfEist5/V4fRnyOV+Lli0tu5vmFXyIU7fp5mHRjkz5JyRF+tbB3tOeYQnaTgeDrCZ9fkoPzcol7zP0c4pzg/RocUEzmdk1qt7IZNhb0kbY8nNqvsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N1fIm3Xf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4217f2e3450so15362655e9.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 06:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718027695; x=1718632495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5jcR5L02HgHvX5QCY1ajcgsHfEcPMZGN1IDlOIPxyo=;
        b=N1fIm3XfD0PwKjTrdYvCY4Htvk03K9bzgw06xSMBBRfFTFMf7nLkqrPkJ4gqwz03mE
         31PG4N71mJ586ur0iA7dcFZMa7c/kK4CP2GR4HAFfAc9nP2+C6C0NhjScNWUyGvMe5FA
         wiiSAMF1gHjivT97nwprVkgKSUzkVzLbrgXH3mDADgzupvFJavn+3KPqAFjwMuZnbAHQ
         ickq4pCtr9wOMAmP7gEOTCbRoVzjSVl38644a93IDfIYwaP9jmf5A8DfTnYy4dEh7Wav
         dg3CvVBxgkiE9EXhPAMdcn8zBijtglKMfOMZu3shcYqCNGbQQSXS1cLRL8Q30B1+sfMv
         w1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718027695; x=1718632495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5jcR5L02HgHvX5QCY1ajcgsHfEcPMZGN1IDlOIPxyo=;
        b=bQ2jCg28waaou4t6gK3vfqp6u57M40K7cNPw5lxMQu3mU34RpjOK7Fo3K5Jr24Nwyc
         1luDhcLD5RkP5bpCsaP7SXLMYvmCZh/O10b5FOssn+FU5casBHuRGwuUk99ZPQUwLsEI
         oSYMZwDDB0APNGYVXH5lP2rL6rCYgZqfqN2AleoS227tpM9SlpO2DLjlMhyAU0Hxmb52
         7bOr7H8INzD7X1uIY0PwwPGrySNImURpt2e55+S9eszI3pTPYOd86xsOLVDXEU2V9678
         KZJu2IN8BwsmANgb7i+ZPgLuDKZv06UGaYxX7PzG4IfNwsW9zNni6fixC1GzlUPzz2KG
         J3RA==
X-Forwarded-Encrypted: i=1; AJvYcCWbj4J9T6vEPxCpNDtG1RDHT67WleB1+Y3Iu73o3N95mgeMm9GanaCYG44d4klggAt41Epv3fAU1N8gRYX6PvMTxkBEOrm0GOs=
X-Gm-Message-State: AOJu0YxYG5nqGnFmVW5UfMbnuS/qDgkBiqFspDxu90n/jc4jpTAnCWtr
	UI9bMR5wA12VFoESAHzqa//1nW35b6GJ2JDhLbcpPNdTyAGSCdMldC1YlXCOXHs=
X-Google-Smtp-Source: AGHT+IH7jGU+FiZVAF0GNsVMTgnY/OvN2Iz19z/aTtH6QgaSwKjyFpwy6xOKmUeEakpoCZEdqiiL2w==
X-Received: by 2002:a05:600c:4748:b0:421:edf4:1e89 with SMTP id 5b1f17b1804b1-421edf42181mr23334825e9.4.1718027694682;
        Mon, 10 Jun 2024 06:54:54 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3? ([2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42182ed2b23sm50824965e9.18.2024.06.10.06.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 06:54:54 -0700 (PDT)
Message-ID: <ee2b258c-8155-49e3-b922-ffe8a0fd1d13@linaro.org>
Date: Mon, 10 Jun 2024 15:54:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] thermal: trip: Rename __thermal_zone_set_trips()
 to thermal_zone_set_trips()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <12458899.O9o76ZdvQC@kreacher> <4937015.31r3eYUQgx@kreacher>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4937015.31r3eYUQgx@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/05/2024 18:50, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Drop the pointless double underline prefix from the function name as per
> the subject.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


