Return-Path: <linux-pm+bounces-315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0A37FAD23
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 23:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693081C208C6
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 22:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A5F487AB;
	Mon, 27 Nov 2023 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NHBb0IP0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3F055AA
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 14:12:58 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-35b0b36716fso4267725ab.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 14:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701123178; x=1701727978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=puE78O4RI+u15yYno75dce4/a2n9AH0YF0ve/Gmlb5Q=;
        b=NHBb0IP0C6hPiBRNBhwtOPT9jec5xHAa1htnTrdTrk9c23Gol3cM/mRY62hgvdV7yS
         WsXqFVP0Z8G0hlDyxQIag4yRrRXMMnvf/NzwbvuNSwRGpj5Z2kxMBIJKhpsSSN9r4b8+
         LN8bJKb/RsP+OBNqIrXdK/bMQi69MKWVxkxV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123178; x=1701727978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puE78O4RI+u15yYno75dce4/a2n9AH0YF0ve/Gmlb5Q=;
        b=TpddP93ABkDzRfOIBPlkCA67TavJ7Q3F/NRiIXr6k/6690GsHeRj9PVg/gnOgl1IpT
         weMB9IhumVFDTUhamrfCumjchgP5CmUo1lyECW/2M82zImEDP61RdNiVoQkFnG19vJmh
         WaGoKU2LQzHOFIPSyLRhvWaIWRhMO97NMFV3T1gStzbtUKoRV94dOMfVjLHGu586pydx
         E+d2eIQjM2xgxtH1LE0p+nr4B+id75YD3LH0zldZxFsDyVL73AazkRWDtxBm5HdSbf+I
         4EAPaVDX6myuKhMjlFJVKDo6JEkFZcdl7EMq7NX/rpQoljViC/vwSDF205tXc5u7NjBw
         LafQ==
X-Gm-Message-State: AOJu0Ywzta0VmR5OK+LBLJizDkHwCLXw64WSVMMHoUY7AR8T3AcZ7F1A
	O8RLe32VID1vGesfZiLlcP/lyw==
X-Google-Smtp-Source: AGHT+IE6AGzwlGF+z7GOguSo74p0/n5g/TMMxCkC6xGkkoe96+I+4m4tenPVLxlT9SvVCDVTMTD2fA==
X-Received: by 2002:a05:6602:2245:b0:7b3:5be5:fa55 with SMTP id o5-20020a056602224500b007b35be5fa55mr13412624ioo.2.1701123178133;
        Mon, 27 Nov 2023 14:12:58 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id az9-20020a056638418900b004665ad49d39sm2541973jab.74.2023.11.27.14.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 14:12:57 -0800 (PST)
Message-ID: <94429ea4-c6a1-4437-8642-3a24930c7ad7@linuxfoundation.org>
Date: Mon, 27 Nov 2023 15:12:57 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools cpupower bench: Override CFLAGS assignments
Content-Language: en-US
To: Stanley Chan <schan@cloudflare.com>, linux-pm@vger.kernel.org
Cc: kernel-team <kernel-team@cloudflare.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231127212049.455008-1-schan@cloudflare.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231127212049.455008-1-schan@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/23 14:20, Stanley Chan wrote:
> Allow user to specify outside CFLAGS values as make argument
> 
> Corrects an issue where CFLAGS is passed as a make argument for
> cpupower, but bench's makefile does not inherit and append to them.
> 
> Fixes: dbc4ca339c8d ("tools cpupower: Override CFLAGS assignments")

There is no need for this Fixes tag since this patch doesn't
fix the problem introduced by dbc4ca339c8d

This patch fixes the problem in bench/Makefile like dbc4ca339c8d
did in cpupower/Makefile.

In this case Fixes tag is incorrect. I removed the Fixes tag
and applied it to

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah

