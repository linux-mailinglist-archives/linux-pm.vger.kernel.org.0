Return-Path: <linux-pm+bounces-747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FFD806E0F
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 12:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794E41C20A29
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 11:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D9831A83;
	Wed,  6 Dec 2023 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QRRm2VuF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C97D1A5
	for <linux-pm@vger.kernel.org>; Wed,  6 Dec 2023 03:33:06 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40bda47c489so49740965e9.3
        for <linux-pm@vger.kernel.org>; Wed, 06 Dec 2023 03:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701862385; x=1702467185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SVOy+xIVPDzsighaco+7FzAHWPggjXl/SyI7kXPYVS4=;
        b=QRRm2VuFsvdhsh+gx/mGSmSu2BHlFwGhUxOZm2vEG5v1r4SUKT+8Si9AMrRl0dqaLO
         iCx8zYz2TybmQRZtilolJAqulibi74L04+cNFZvz2szXaG5Bv6B91N3x8E6gM6c/piXl
         xd62SQ1F3BEoEwvVVZzPgJmPsqxG/rEKOWRjUdG2uKdyjXOaAjD8XRJqJ8qjB95GrCfl
         4TdQzvEzW408Iy9ETs64fUn3BjtL6eRUzZctbh3OqHF/ke8Un4KIFCN78011BsmDmA0g
         uYIwSnS2PSMsEZUwg8PYVRtUG5RT1hC3q9iQ0UZhea8Op777oO0hfSABz1vPHGKAo3iL
         oVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701862385; x=1702467185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVOy+xIVPDzsighaco+7FzAHWPggjXl/SyI7kXPYVS4=;
        b=lha5ZvfU9KM3AfLzJG59gnIdfEp1sHrKhlUkxNGLz2ZA6ajxksdME6q001d1jFGcKp
         CETu9StKC5+8T8DIAoqbnWTdmQO/BRWWcBPLpzQkg7wo25U9UVvBovSw0Mb4H0+o/PFy
         JocYcyBUeSut3imRa6S7Ha05pCKcMWnawBLHR7YjZUCH8D4uqU+WIPFv/giY197r80Pn
         Z7IiLy7j7gGOmTJ9IQBI43QoKC7IlAU24shjpykNdgseB10AiJn0L1S49Qylr2gEm1Hy
         fT77QcRPe0pgOj1YGih8n7kQsonRJf+7/ny21hTEsGhC/25FMAWzvRn0dwily7Btha6g
         G+jw==
X-Gm-Message-State: AOJu0YyLLZAaCt7cjryALPtPllPHiOmB9iFzN+IvY/JdyQ46q1YqsuQe
	hp+e+U5zkVhFU75XMCeFHGtrNQ==
X-Google-Smtp-Source: AGHT+IFTLrukb+Vz598ttYpjIdkTKcdA6ZNWu7MtBTIc70l0z/SJbaXoUx1RTGJOmn2t2Ku6ghisbg==
X-Received: by 2002:a05:600c:4a12:b0:40b:5e21:d338 with SMTP id c18-20020a05600c4a1200b0040b5e21d338mr526890wmp.65.1701862384945;
        Wed, 06 Dec 2023 03:33:04 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id e5-20020a5d4e85000000b0033333bee379sm13279430wru.107.2023.12.06.03.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 03:33:04 -0800 (PST)
Message-ID: <43046604-c67c-455e-8878-01425be40c60@linaro.org>
Date: Wed, 6 Dec 2023 12:33:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] thermal: sysfs: Rework the handling of trip point
 updates
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <12337662.O9o76ZdvQC@kreacher> <4882089.31r3eYUQgx@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4882089.31r3eYUQgx@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/12/2023 13:24, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Both trip_point_temp_store() and trip_point_hyst_store() use
> thermal_zone_set_trip() to update a given trip point, but none of them
> actually needs to change more than one field in struct thermal_trip
> representing it.  However, each of them effectively calls
> __thermal_zone_get_trip() twice in a row for the same trip index value,
> once directly and once via thermal_zone_set_trip(), which is not
> particularly efficient, and the way in which thermal_zone_set_trip()
> carries out the update is not particularly straightforward.
> 
> Moreover, input processing need not be done under the thermal zone lock
> in any of these functions.
> 
> Rework trip_point_temp_store() and trip_point_hyst_store() to address
> the above, move the part of thermal_zone_set_trip() that is still
> useful to a new function called thermal_zone_trip_updated() and drop
> the rest of it.
> 
> While at it, make trip_point_hyst_store() reject negative hysteresis
> values.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


