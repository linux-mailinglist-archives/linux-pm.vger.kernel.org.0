Return-Path: <linux-pm+bounces-1043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EF8810CA1
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 09:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0C41F21072
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 08:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813BE1DDDC;
	Wed, 13 Dec 2023 08:42:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEECAAC;
	Wed, 13 Dec 2023 00:42:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 965ADC15;
	Wed, 13 Dec 2023 00:43:18 -0800 (PST)
Received: from [10.57.85.168] (unknown [10.57.85.168])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A10F3F762;
	Wed, 13 Dec 2023 00:42:31 -0800 (PST)
Message-ID: <ac47d127-a57a-4b93-a96c-2ced114dc554@arm.com>
Date: Wed, 13 Dec 2023 08:43:35 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] thermal: Use for_each_trip() in some places
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>
References: <5733564.DvuYhMxLoT@kreacher>
 <CAJZ5v0hU12yWQstAFuDkid0iWxdh7biPy33BA8XfhczFWCVX5Q@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0hU12yWQstAFuDkid0iWxdh7biPy33BA8XfhczFWCVX5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 12/12/23 18:59, Rafael J. Wysocki wrote:
> On Mon, Dec 4, 2023 at 8:49 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> Hi,
>>
>> This series changes the code to use the for_each_trip() macro in a few
>> places instead of open-coded loops over trip indices.
> 
>  From the lack of comments I gather that the changes in this series are
> fine with everyone, so I'm going to queue it up for 6.8.
> 
> Thanks!
> 

Somehow I missed that series. Although, I've checked them today
and LGTM. So feel free to add my tag to thepatches if it's not too late:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz

