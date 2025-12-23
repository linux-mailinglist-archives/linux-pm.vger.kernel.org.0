Return-Path: <linux-pm+bounces-39827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F16CD8701
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 09:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DE14300912E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 08:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3C23191A1;
	Tue, 23 Dec 2025 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="a781HOaB"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEA43191CE;
	Tue, 23 Dec 2025 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766477743; cv=none; b=Advoq1psH7lVvAjhMOxK8CtTHhOCG/+WHh7FrYERyG0FygaJF5yoOLVZOWXmaKfJuhX1427mZ+d0fIblfqCz7jySIqEzX2MKsFIEoZmoQ7EfRtby1nSuGpzhjK7qshXifv5j/+YcGn6sqqESyaoaqPpMOnaZ8EqxkbT68/0PZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766477743; c=relaxed/simple;
	bh=90beF36HRDkHSXfFGP6TgMXG4aVAwTVZ/XtLIOg3gQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VIFiylyZ91MYlSzL+Em2YxUZkxadzVC6LRLF3gt8pguNgnzPeg81PjFP6S7KnlzFdP/liPGbcm6dnjxPMvFAAUCmnjyHiryNvS9DtyEF3TRGUmPNjz/nhInVXiUjRHjEXh3OXIi2ZlUJgzXg+6vLpSjUPjvtZ+zZuL+PPtjz5Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=a781HOaB; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NcGUZVN2EzwAzRNde3V4PIBeXchFkAKnQj5prt/f8J4=;
	b=a781HOaBDcd0JIEq6MBR326cOPHhuPrcGcnQzd5zmq+Kk/MuL45UYbLRNHMTtjNizZwxAn80y
	Jx4UiX0zsmTtTToRNRORczH+RCCADEKk9n3cdzujljyY0CVarXC5ePjdVH/hNco5erUmBJ0q0HP
	grmGugrDA67ijqC3TDibDZM=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4db7661YpMzLlVp;
	Tue, 23 Dec 2025 16:12:30 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id CED1240563;
	Tue, 23 Dec 2025 16:15:35 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Dec
 2025 16:15:35 +0800
Message-ID: <ea9111b5-cd85-4526-a959-54d8037d6ffb@huawei.com>
Date: Tue, 23 Dec 2025 16:15:34 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cpufreq: Update set_boost callbacks to rely on
 boost_freq_req
To: Pierre Gondois <pierre.gondois@arm.com>
CC: <linux-kernel@vger.kernel.org>, Christian Loehle
	<christian.loehle@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, Jie
 Zhan <zhanjie9@hisilicon.com>, Huang Rui <ray.huang@amd.com>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>
References: <20251208105933.1369125-1-pierre.gondois@arm.com>
 <20251208105933.1369125-4-pierre.gondois@arm.com>
 <14ad55ce-413f-46e0-9ce0-f35fc421056c@huawei.com>
 <73da1186-5edd-4465-bd49-e18d9064a501@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <73da1186-5edd-4465-bd49-e18d9064a501@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/12/18 0:22, Pierre Gondois wrote:
> cpufreq_frequency_table_cpuinfo() can effectively update
> policy->cpuinfo.max_freq, but directly setting policy->max should be wrong
> as it bypasses the other QoS constraints on the maximal frequency.
> 
> Updates to policy->max should go through the following call chain
> to be sure all constraints/notifiers are respected/called.
> freq_qos_update_request()
> \-freq_qos_apply()
>   \-pm_qos_update_target()
>     \-blocking_notifier_call_chain()
>       \-cpufreq_notifier_max()
>         \-handle_update()
>           \-refresh_frequency_limits()
>             \-cpufreq_set_policy()
> 
> FYIU, we should have:
> - max_freq_req: the maximal frequency constraint as set by the user.
>   It is updated whenever the user write to scaling_max_freq.
> - boost_freq_req: the maximal frequency constraint as set by the
>   driver. It is updated whenever boost is enabled/disabled.
> - policy->cpuinfo.max_freq: the maximal frequency reachable by the driver.
>   This value is used in cpufreq at various places to check frequencies
>   are within valid boundaries.
> - policy->max: the maximal frequency cpufreq can use. It is a resultant
>   of all the QoS constraints received (from the user, boost, thermal).
>   It should be updated whenever one of the QoS constraint is updated.
>   It should never be set directly to avoid bypassing the QoS constraints.
> 
> Whenever a cpufreq driver is initialized, policy->max is set, but the
> value is overridden whenever the user writes to scaling_max_freq.
> Thus we might think it should be replaced with a max_freq_req constraint.
> 
> However if boost is enabled, the maximal frequency will be limited by
> max_freq_req. So at init, cpufreq drivers should set boost_freq_req
> instead (to policy->cpuinfo.max_freql).
> That way, if boost is enabled, the maximal frequency available is the
> boost frequency.
> 
> ------
> 
> Summary:
> -
> policy->max should never be set directly. It should only be set through
> cpufreq_set_policy(). cpufreq_set_policy() might be called indirectly
> after updating a QoS constraint using freq_qos_update_request().
> 
> -
> boost_freq_req should be set for all cpufreq drivers, with a default value
> of policy->cpuinfo.max_freq. This represents the maximal frequency available
> with/without boost.
> Note: the name "boost_freq_req" might not be well chosen.
> 
> -
> Any update to policy->cpuinfo.max_freq should be followed by a call to
> freq_qos_update_request(policy->boost_freq_req).
> This will allow to update "policy->max" with the new boost frequency.
> 

Hi Pierre,

I now think we might not need to add a new QoS constraints. Calling
refresh_frequency_limits() instead of freq_qos_update_request() when
setting boost might solve your problem, since cpuinfo.max_freq is already
used to limit policy->max in cpufreq_set_policy().

What do you think?

