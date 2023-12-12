Return-Path: <linux-pm+bounces-1011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E017680F5CB
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 19:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0CC1C20D91
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 18:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02157F567;
	Tue, 12 Dec 2023 18:51:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51AE1E3;
	Tue, 12 Dec 2023 10:51:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69D191FB;
	Tue, 12 Dec 2023 10:52:30 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF61D3F762;
	Tue, 12 Dec 2023 10:51:41 -0800 (PST)
Message-ID: <d21b3514-76f0-4571-b904-7b6f3e536328@arm.com>
Date: Tue, 12 Dec 2023 19:51:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/23] Documentation: EM: Update with runtime
 modification design
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-24-lukasz.luba@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20231129110853.94344-24-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/11/2023 12:08, Lukasz Luba wrote:
> Add a new section 'Design' which covers the information about Energy
> Model. It contains the design decisions, describes models and how they
> reflect the reality. Remove description of the default EM. Change the
> other section IDs. Add documentation bit for the new feature which
> allows to modify the EM in runtime.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  Documentation/power/energy-model.rst | 206 +++++++++++++++++++++++++--
>  1 file changed, 196 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
> index 13225965c9a4..1f8cf36914b1 100644
> --- a/Documentation/power/energy-model.rst
> +++ b/Documentation/power/energy-model.rst
> @@ -72,16 +72,48 @@ required to have the same micro-architecture. CPUs in different performance
>  domains can have different micro-architectures.
>  
>  
> -2. Core APIs
> +2. Design
> +-----------------
> +
> +2.1 Runtime modifiable EM
> +^^^^^^^^^^^^^^^^^^^^^^^^^

The issue I see here is that since now the EM is runtime modifiable and
there is only one EM people might be confused in locking for a
non-runtime modifiable EM. (which matches the design till v4).

So 'runtime modifiability' is now feature of the EM itself.

There is also a figure in this document illustrating the use of
em_get_energy(), em_cpu_get() and em_dev_register_perf_domain().

I wonder if this should be extended to cover all the new interfaces
created for the 'runtime modifiability' feature?

[...]

