Return-Path: <linux-pm+bounces-24685-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DBCA776AB
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 10:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E7F3A72F7
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 08:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3D11EB1B2;
	Tue,  1 Apr 2025 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldqhGzSy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAFF1A83E4
	for <linux-pm@vger.kernel.org>; Tue,  1 Apr 2025 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743496990; cv=none; b=MBA9XV2+n6VG9dWDRLss6fgpX21H4SbKLz+KO9jkuKZnSk6eUcKBr1K0tg4doICmmQW74kt58423FWTG50mYe53ofA8DagSZTm2GZqJua8wl3sCqaWNEuU6jcA1qNToXesJfZLHFteAkpzE3X7skdZRvODeKTW1S15jpWIL5wUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743496990; c=relaxed/simple;
	bh=eAyulgNwDugXHRNPeWxQlca5IJS6fxeG7RYNHW4gZNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJDy9hE0Mprq47Q3PHrTlL+ZWdbSig8HrsQxsqqA2lL9oWE8qk+QfXumY5oTe1wqXdFR+eI1vgFVO8PO3Nwi6kTbfBbYxH3PYa+Ew3+AEGQtKVY/oPGOtpA8FZLYXh4SWMnjqVIMxrIHP+3QDyDuAU0NmAiNeK+Xs6LzwKX4Obk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ldqhGzSy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2243803b776so29279855ad.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Apr 2025 01:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743496988; x=1744101788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZW4RptpbO/MsEel2xtnMMoJ2QXkHyUdyfTKR4GsWHh0=;
        b=ldqhGzSy6RaU4Om1Bfn4pChhNBfj+NzRZ4fDCh5eAphzaUvsWD325OOJb4seEKTt5i
         FNIOg+CtS/dB/XCrgGf1G8e6MIiDkKYY5jC/mthp2BmTYGiGVEfpde8QeSNGm5OLuuvG
         426p9IdzyP4Umy/MHbd430GABj0j4qOCZDghEqV84ibj+puB9hey0fVRUYh4zuiDweSr
         Av4No17P2vypwWM4KM4wx0zi+HoGLHJeRnMpO52OPozDR67x9p0am9W15URl9EthfkaG
         qJ0qUHhCC/3ebfMVFb+8/3sZUtmQNMGxNwOl7rtcQ5OHACKPwgTeF+QPu2IhMnviSMly
         Lk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743496988; x=1744101788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZW4RptpbO/MsEel2xtnMMoJ2QXkHyUdyfTKR4GsWHh0=;
        b=MVymbddKsLDMtW2o5MKvcTd2/aHPQKd+ob0gWO3rqOcLkdUGj/ZCoxHg6dLMHALX5I
         L9ABQLtKOlKuvFbtTsVtJ+tapUNAgh1bMAajShBGV+au2F6oCmlucy/t4w1c0vJzZJci
         y1dj2AXTmsL3E7Shc4Vf0jLPekSORdrUrb+SuDzsPpu9TaB/90GxynVXqzNr/b7jy1fI
         /ONCjatFh8rwCj7NiNk+wFo1T0whktERe5OqbZEURarx/4FxVB4Z89J4vNVC+j9zFULR
         mTtWlaKxXEcD+2Y/9oE6+LrDSxzh3ZfjyLw5fUcGJcUmhnJfn5I3V05/apzNNnNoUOEP
         1rbg==
X-Gm-Message-State: AOJu0Yz0fXyuj16vxlQv1UsgoK1hPsZoy0HuZhYwMuNF0AUQaG687IHH
	MEU9koG3QH8oWzOMm1j7w24WkHJfDYlWUHc47Ihxwb/M3CFyH6vkXlNhJrIlmLg=
X-Gm-Gg: ASbGncuk5jr8sfvij3WnMjzHZIU7bRh48MRKCHRDD5wbsm7HPeC9r8bqUNAAIKqYyZ8
	fqKSUwPUtDcLJCEH14oj8cF6DrGqlEgOmdOnKYRyWWHcyVri0e/xp23Qo2JyZ+9iFb7HfDICVbu
	2UaLjxwW3ZZ73Y1wMEGy/T+F1fej/mT/ynEH0iywZqqNKToMUOFeVkk42AR6pG80FDeW2DwZkBO
	2mDyExM+E7QVEP5uOYA79kvdmN2odWZLfHcCl4fLeIsysm/rhjKAKobkUqKr0V2LtD5H0FmZGrl
	2DPwxc+BuxnesQTJXx5yZSRQdS3uswD6A3EPnOwJzorhXg==
X-Google-Smtp-Source: AGHT+IGfWZI0lHW9gqmfyGE0TUy3057d/eSS3S8FL2AMcp3BOyfnLTFlpo4ryW3cDKuDszcFg3ziVA==
X-Received: by 2002:a05:6a20:9e4a:b0:1f5:730b:e09a with SMTP id adf61e73a8af0-2009f644c21mr19182247637.20.1743496987833;
        Tue, 01 Apr 2025 01:43:07 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93ba10da3sm7574276a12.66.2025.04.01.01.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 01:43:07 -0700 (PDT)
Date: Tue, 1 Apr 2025 14:13:05 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v1 04/10] cpufreq: Add and use cpufreq policy locking
 guards
Message-ID: <20250401084305.setqyk765dwo6jqk@vireshk-i7>
References: <4651448.LvFx2qVVIh@rjwysocki.net>
 <8518682.T7Z3S40VBb@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8518682.T7Z3S40VBb@rjwysocki.net>

On 28-03-25, 21:42, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Introduce "read" and "write" locking guards for cpufreq policies and use
> them where applicable in the cpufreq core.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |  121 ++++++++++++++++++++--------------------------
>  include/linux/cpufreq.h   |    6 ++
>  2 files changed, 60 insertions(+), 67 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

