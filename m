Return-Path: <linux-pm+bounces-375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B460D7FBCAA
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 15:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64371C20E6E
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 14:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7A65AB9D;
	Tue, 28 Nov 2023 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 473C1B7;
	Tue, 28 Nov 2023 06:23:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C434C15;
	Tue, 28 Nov 2023 06:24:28 -0800 (PST)
Received: from [10.57.2.117] (unknown [10.57.2.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07CAF3F6C4;
	Tue, 28 Nov 2023 06:23:39 -0800 (PST)
Message-ID: <95757bf5-a7c3-48ac-86b8-62e28680d903@arm.com>
Date: Tue, 28 Nov 2023 14:24:39 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powercap: DTPM: Fix unneeded conversion to micro-Watts
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 daniel.lezcano@linaro.org, stable@vger.kernel.org
References: <20231127092819.2019744-1-lukasz.luba@arm.com>
 <CAJZ5v0hun3D29w0DMgaSoaGpLNLP4dWN-mYpRHYESdFwP6iRsQ@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0hun3D29w0DMgaSoaGpLNLP4dWN-mYpRHYESdFwP6iRsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/28/23 14:17, Rafael J. Wysocki wrote:
> On Mon, Nov 27, 2023 at 10:27 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> The Power values coming from the Energy Model are already in uW.
>> The PowerCap and DTPM framework operate on uW, thus all places should
>> just use the values from EM. Fix the code which left and still does
>> the unneeded conversion.
>>
>> Fixes: ae6ccaa65038 (PM: EM: convert power field to micro-Watts precision and align drivers)
>> Cc: <stable@vger.kernel.org> # v5.19+
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>> Hi Daniel,
>>
>> I have found an issue due to the uW in the EM. My apologies for that.
> 
> No need to apologize, you are making the code better.

I apologize because I introduced this uW change in the EM fwk :)
although I missed those DTPM bits which are now fixed.

Daniel told me last week that I can easily test the DTPM using
the rockpi code (because it was a pain for me in some hacks
trying to test DTPM).

> 
>> I have check those with the Rockpi dev board with your DTPM module there.
>> BTW, if you like to check the DTPM_devfreq there, you can apply that
>> patch. It should create EM for your GPU there and setup DTPM GPU:
>> https://lore.kernel.org/all/20231127081511.1911706-1-lukasz.luba@arm.com/
>>

[snip]

> 
> Applied as 6.7-rc material, thanks!

thanks Rafael!

