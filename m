Return-Path: <linux-pm+bounces-33731-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2579AB4230B
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 16:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB34585112
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8620B311959;
	Wed,  3 Sep 2025 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRQcU94k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26C830F52B;
	Wed,  3 Sep 2025 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908294; cv=none; b=NuuGHtJomQUg/eovX4KkBNBZmVuhvi1/xh8zTyR5oveH0kmc01l+rlQ16PG1pWBGd0fxRxJyBl/LTIXhyccl/ZxH6LSm2EsGt7XeaqwsTqBLAtyXgvxWMxZhawNhCMeIfGHYlJ/q0nCfeZZVgxJNNmWFtTLzT3hUHpnazuGyvIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908294; c=relaxed/simple;
	bh=WlYdqytM/Vj98qRczF+ba6NXkIY9WaVkU2I4vOVFzvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftRfdfKhmvMSvCTVjczelr25LVgnE2ako1amOmx3A6z/q8YxhDXhyisztPw76GBru2L/doVko1d3KMkA3m+gCabR9vN513PZzCs9euUugyametxa72ws/ozmAPeowmDncxp4md89Tfa8afEy5M5dS67EhL5PSv2F6gNlgik2UyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRQcU94k; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aff0365277aso166767266b.1;
        Wed, 03 Sep 2025 07:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756908291; x=1757513091; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=elJSkPEBBVngQQj4aVEZfKL8gC/PHjpdX2yIo3pkLZE=;
        b=RRQcU94k5M+1MscYvHVGcyKw/dOYWPa97HJMzSdGGn+Q9syho4hHlv6k26VqZFbrD7
         7iyAoNBjkouMb90sTSMxfSKeWI3p9bw0LyOFGx3LQpTz8J3YHQSL56KoMNbS6TH7sHOp
         8xJgWOicPTLjXtkp9ZMH5OTMaGkwh5n/Q+jODLt2fT2pK/yBp3GNV0Sjl1vf0seYq/3d
         JIbXR+b8CoVF3YKHWBrDFHFqdEEGg1xi1zhFOk6TMHzV/zScdHGcHFhns2Psqhp1lM4g
         b/SdaIqLt08lH59gZiiKJhCgXn06JHXGW1/cytbFirWsLQOCMHsAu2vF7ZkmlUF0cJMM
         E9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908291; x=1757513091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elJSkPEBBVngQQj4aVEZfKL8gC/PHjpdX2yIo3pkLZE=;
        b=Efo4QJKHXT0TQSlwCfBa7ckyTS+x9kW3CGvENw+r6wb/optJA88wZ8ubOsmJKBNhcY
         9WcaF7HWR4Z7GCLT+Qb6c10frPcOmijfg9WAVx3jGsY+4F6fToUIDIgmtvWWxbOgG6qS
         Wa1VG7jPsFNTCccHhtkv5Odk6+YcuTaICvjaqK9Xx3pZtWaZHT10GF90HrIIs2lHNUn/
         8wa8ZjJY/ghcomAGWcXfollieICljWQOTgmypLS7zq3GqB9+jWkZEAbMHSETrWZ8l0Zx
         nNRp9iEUmxQM3TlaKNIO4syOVIFxDTapdbsAofmcXMpmX+WVT1tE6EgRvQcIMg8E9+tT
         5aQw==
X-Forwarded-Encrypted: i=1; AJvYcCVJIaY3Nfc+KxWo8lcaHzSjMj9q8DozflFH12P0Wuy29VMELwZeRY9mS8Ks1qiN5jtRUahzJTun2ZDDkQA=@vger.kernel.org, AJvYcCXAyz+LnIrXMb7OA0hGM9lrC2IZ2qZq4EEg6rlBe/OlPrmflgU7+HMg2ur65UgwaC5M3UqSHE1KQ/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmDThxOdmjXTZf6lBuapMO3v6IcPyUD/Q26CAbuCRCog2mlsjr
	KJxK7MEEEAY300CwKQLqwXun2c9IxljVHM1wSfI4HRRYvBRGyu1WIg48
X-Gm-Gg: ASbGncvAQtUDqRgRt7Z5sw26CJ0cTG8OduWxTq8kPRpxhYPY9nwtW4TLOHLcj10l1Wd
	LCg366KupKMzhLTXKjzguBcPFGSMz0tNM3LCpXlv4siM0HFs42Y0pdwN6CXk5nfYABmvWq8W/zS
	F2VmIONn6du6bsCFcgR2ylqUMQftzABYkVMK/dvovy0gQJcptmLe7sVOVxwgARDGZ2gcpHMK9cL
	3Gh1xXCURh4jG0L/SOxPJBFkLqjqTSNhl3bZPybOSsz7/NZWHRi9ynE3XRE8C0PUwb7EdGC3o0Q
	KS9MmDMigdrD5Vv+ReUcAwbFD56j6qLm6CBlytavwfkSxyVPtQ2hOdRDu3Oj6Ij3c2oWC4zwOdV
	i+CG9xPg9CF5aspBvQCQ70+9ERnf/lBbyRhva7/J9J3Z/oiumL3G7a96Nm8cXBj2NIpzP180iee
	mjA0Dl
X-Google-Smtp-Source: AGHT+IH9sChVGEdo1pXaN7DIDwBJVmaRZi8ChKV/MLQ8N2XXlJDN/wp+PCoVDTfqcuNcGwkyxzlkAw==
X-Received: by 2002:a17:907:7207:b0:b04:5888:7a7d with SMTP id a640c23a62f3a-b0458887c81mr462554166b.22.1756908290474;
        Wed, 03 Sep 2025 07:04:50 -0700 (PDT)
Received: from osama ([2a02:908:1b0:afe0:f7e0:2e82:8677:dae8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61ec74de341sm3124045a12.4.2025.09.03.07.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:04:49 -0700 (PDT)
Date: Wed, 3 Sep 2025 16:04:47 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: hwmon: replace deprecated strcpy() with
 strscpy()
Message-ID: <aLhK_zMvtkdCtsHR@osama>
References: <20250901150653.166978-1-osama.abdelkader@gmail.com>
 <CAJZ5v0hrKBNxDeZOKpUXyuZV7LRUX4ov4ifEGDtNMrA8km6uOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hrKBNxDeZOKpUXyuZV7LRUX4ov4ifEGDtNMrA8km6uOA@mail.gmail.com>

On Wed, Sep 03, 2025 at 01:50:03PM +0200, Rafael J. Wysocki wrote:
> On Mon, Sep 1, 2025 at 5:06 PM Osama Abdelkader
> <osama.abdelkader@gmail.com> wrote:
> >
> > strcpy() is deprecated; use strscpy() instead.
> 
> So why is it better to use strscpy() in this particular case?

Thanks for the review. Technically, there is no change since both have const buf size,
it's just for consistency with other drivers.

Regards,
Osama

> 
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> >  drivers/thermal/thermal_hwmon.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> > index 0ecccd4d8556..64cc3ab949fe 100644
> > --- a/drivers/thermal/thermal_hwmon.c
> > +++ b/drivers/thermal/thermal_hwmon.c
> > @@ -96,7 +96,7 @@ thermal_hwmon_lookup_by_type(const struct thermal_zone_device *tz)
> >
> >         mutex_lock(&thermal_hwmon_list_lock);
> >         list_for_each_entry(hwmon, &thermal_hwmon_list, node) {
> > -               strcpy(type, tz->type);
> > +               strscpy(type, tz->type);
> >                 strreplace(type, '-', '_');
> >                 if (!strcmp(hwmon->type, type)) {
> >                         mutex_unlock(&thermal_hwmon_list_lock);
> > --
> > 2.43.0
> >

