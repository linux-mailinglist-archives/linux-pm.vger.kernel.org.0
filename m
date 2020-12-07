Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75062D0A47
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 06:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgLGFhY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 7 Dec 2020 00:37:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51827 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgLGFhY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 00:37:24 -0500
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1km9CT-0000KG-NT
        for linux-pm@vger.kernel.org; Mon, 07 Dec 2020 05:36:41 +0000
Received: by mail-pf1-f198.google.com with SMTP id z68so8481871pfc.0
        for <linux-pm@vger.kernel.org>; Sun, 06 Dec 2020 21:36:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YwGMi9iNd6O/Jb8LuzDIfb7n8JTTcq96cUgR5LZJ6ho=;
        b=KL6akK31KJ+djJ70OzkxKohIdBJ3mb08wZ2Ubxt7OsaiMhEXHRffiCcVmBrQfC9sLu
         RQ+VVf6vn12QcEawEQeHi8VyXs6yRiIPrTGckWQXdHFJau2gueWidWAh2JjhPcz2MVF5
         apvCzkLe+E1K6n5uMsU9yi6im25mh9xIr0D5Fl3SsCJXUXDhKcxiZLFLF1bZQRIUebkr
         1aK6fG1jD4t1KVZX2lAZAOKCKKI4RvdbC9f+tueXBu+HelhxfQ/hi8FqWi0Yw0Alb42m
         zVdGfSVCgAWC4p0Kybf7XJUpKdpP6xD4BEL4JRnwGTVB7Vxq9GV0Ufcm+emFagIQCe3d
         X9OA==
X-Gm-Message-State: AOAM532ota1S0AfhFCQNfL1iMNi+mpiDm4f5c4ujHnRneOprRER3FEFP
        Qd5fraTZVEROf+PGSV4XuLK6v4WXRxEy+JyLRvbGvdZHO5Oj5UMaispbm3bHypBMWC38wdulDAM
        RluTYFWU/5fgAlzihmFuNSV21t7FHXxadLJbq
X-Received: by 2002:a17:902:830a:b029:da:df3b:459a with SMTP id bd10-20020a170902830ab02900dadf3b459amr8931036plb.75.1607319399824;
        Sun, 06 Dec 2020 21:36:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOvWqW1KGPx37vxNpQuOkkh0LYbbhwGCUnQvxzO9fmn844rtNnaDBgPn+0nSp9WkuOTdXViQ==
X-Received: by 2002:a17:902:830a:b029:da:df3b:459a with SMTP id bd10-20020a170902830ab02900dadf3b459amr8931014plb.75.1607319399534;
        Sun, 06 Dec 2020 21:36:39 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id 22sm12021202pfn.190.2020.12.06.21.36.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 21:36:38 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH 1/3] thermal: core: Add indication for userspace usage
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <f863f2e1e322a8819c660f5eefbbc4acf7522990.camel@linux.intel.com>
Date:   Mon, 7 Dec 2020 13:36:35 +0800
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>, amitk@kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <FCFE1F21-2EC6-4D3A-8B2E-32C653816D58@canonical.com>
References: <20201128175450.12456-1-kai.heng.feng@canonical.com>
 <004fe225-1009-06d8-b297-c03a4c67550f@linaro.org>
 <860126B8-1152-4EE3-B15E-B4E45EFE879F@canonical.com>
 <fc67ad02826fb3adfd8457e1a0baf234a8fa3fce.camel@linux.intel.com>
 <34348B03-5E27-49A0-A704-6332BAC00758@canonical.com>
 <585bb5d3ee5bea063795682108576c3464ba72b6.camel@linux.intel.com>
 <D53454A1-5ED0-4B4D-B22F-8663C9970ECD@canonical.com>
 <f863f2e1e322a8819c660f5eefbbc4acf7522990.camel@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> On Dec 1, 2020, at 02:39, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> 
> On Tue, 2020-12-01 at 02:22 +0800, Kai-Heng Feng wrote:
>>> On Dec 1, 2020, at 02:13, Srinivas Pandruvada <
>>> srinivas.pandruvada@linux.intel.com> wrote:
>> 
>> [snipped] 
>> 
>>>>> What about creating an new callback
>>>>> 
>>>>> enum thermal_trip_status {
>>>>> 	THERMAL_TRIP_DISABLED = 0,
>>>>> 	THERMAL_TRIP_ENABLED,
>>>>> };
>>>>> 
>>>>> int get_trip_status(struct thermal_zone_device *, int trip,
>>>>> enum
>>>>> thermal_trip_status *state);
>>>>> 
>>>>> Then in 
>>>>> static void handle_thermal_trip(struct thermal_zone_device *tz,
>>>>> int
>>>>> trip)
>>>>> {
>>>>> 
>>>>> /* before tz->ops->get_trip_temp(tz, trip, &trip_temp); */
>>>>> if (tz->ops->get_trip_status) {
>>>>> 	enum thermal_trip_status *status;
>>>>> 
>>>>> 	if (!tz->ops->get_trip_status(tz, trip, &status)) {
>>>>> 		if (status == THERMAL_TRIP_DISABLED)
>>>>> 			return;	
>>>>> 	}
>>>>> }
>>>>> ...
>>>>> ...
>>>>> 
>>>>> }
>>>>> 
>>>>> 
>>>>> This callback will help the cases:
>>>>> - Allows drivers to selectively disable certain trips during
>>>>> init
>>>>> state
>>>>> or system resume where there can be spikes or always. int340x
>>>>> drivers
>>>>> can disable always.
>>>> 
>>>> This sounds really great. This is indeed can happen on system
>>>> resume,
>>>> before userspace process thaw.
>>>> 
>>>>> - Still give options for drivers to handle critical trip even
>>>>> if
>>>>> they
>>>>> are bound to user space governors. User space process may be
>>>>> dead,
>>>>> so
>>>>> still allow kernel to process graceful shutdown
>>>> 
>>>> To make the scenario happen, do we need a new sysfs to let
>>>> usespace
>>>> enable it with THERMAL_TRIP_ENABLED?
>>> This should be drivers call not user space.
>> 
>> Understood. So after thermal_zone_device_register(), the driver can
>> decide to what to return on get_trip_temp().
> get_trip_status()
> 
>> Let me work on a new patch if there's no other concern.
> Better to wait for confirmation from Daniel and others.

Daniel,

Do you like Srinivas' proposed solution?

I hope we can find a solution in upstream kernel soon.

Kai-Heng

> 
> Thanks,
> Srinivas
> 
>> 
>> Kai-Heng
>> 
>>> Thanks,
>>> Srinivas

