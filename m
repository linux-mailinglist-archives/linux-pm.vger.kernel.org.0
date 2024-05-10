Return-Path: <linux-pm+bounces-7706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0B78C2018
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 10:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09CE0281980
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 08:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCB415E800;
	Fri, 10 May 2024 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="n5lrxoUq"
X-Original-To: linux-pm@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0311E77119;
	Fri, 10 May 2024 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715331272; cv=none; b=a3a4oMfx6YbwHUVrUjXck4fxCbnG/PfmfkNGoziRGYxDC73DcsQEkG1/8bHQMZHmjlVIy3LONIgX2frKt5Zp+6lU9k7QBqBSPWT1CSKdbfVWPo0DecD8Is7m0sGrX4t+b+8z6iem0bKhAZQ1dpR397XGiyuUF4c/pMdUkDDDdoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715331272; c=relaxed/simple;
	bh=hQh69XXg8WmmpjNwp3ptOQRA0J1YkUC8jjY7pRN0Uy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eG/ImH+E+m0+h8e20JoMwg6h7DtAqBeyZwZ9+0ngCEdnctJ1JdaAIal9HLtBntLY7ws+A7ANuxsH3aSiaH3AOdm2Qp7/nAO7T+EblyfU4/POjs4ZE3H5nQEA30BBhapvs8Ypeur+ifzYbTZKEtLbHJ+5Bs2hAUHJZ6bA0XQ2yjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=n5lrxoUq; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=x+O1cSPAUS4W5mCMKpUnvjbNoTiI4f9De88+AtYShLk=;
	t=1715331270; x=1715763270; b=n5lrxoUqlg02dy8CYsGzhMiK1vh/KelDPI5XtS4/VxlyKec
	QVJI3nEL4VZOT7H54ymD6+eLx5f7vO0lPHVaK2+6ZxWCVXseB7uqxHuMry88NUBsU+Oenz4kdAg/X
	M9mgzzmlEMmrLAW6DSI15DrLbLeaetL3icb7XZmdlxW5mbq+KJY35Qz7cRaqTE2wvAn+xt6352Vo7
	3xodvIq5qCb/THTqpOdIq3IUbyN941Z0LKZSku2oC8KBs5QT09Wk+6oCu/LX30nbUCTSjCYoPWVqK
	X0GISbTearGY6Es9K7wIgdocU5tx/+CIn8mSCJ8bcKU+DdOs/ZTxOtNhFp2VsEWA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s5M1J-0006Pa-VH; Fri, 10 May 2024 10:54:26 +0200
Message-ID: <7c6df194-fce1-401a-98c5-c903d78627c4@leemhuis.info>
Date: Fri, 10 May 2024 10:54:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] OPP: Fix required_opp_tables for multiple genpds using
 same table
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Viresh Kumar
 <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Vladimir Lypak <vladimir.lypak@gmail.com>, linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <2eb72832e852c80e5c11cd69e7d2f14cefd8b1cb.1712903998.git.viresh.kumar@linaro.org>
 <e6fc06eb-fe52-4cb3-b412-a602369ee875@leemhuis.info>
 <CAPDyKFoHoKK-RZsGwnZhbW9_ZRQtL1MFZBuVVLMx-MxL2cQQbw@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAPDyKFoHoKK-RZsGwnZhbW9_ZRQtL1MFZBuVVLMx-MxL2cQQbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715331270;16a695cb;
X-HE-SMSGID: 1s5M1J-0006Pa-VH

On 10.05.24 10:37, Ulf Hansson wrote:
> On Thu, 9 May 2024 at 14:35, Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>> On 12.04.24 08:41, Viresh Kumar wrote:
>>> The required_opp_tables parsing is not perfect, as the OPP core does the
>>> parsing solely based on the DT node pointers.
>>>
>>> The core sets the required_opp_tables entry to the first OPP table in
>>> the "opp_tables" list, that matches with the node pointer.
>>>
>>> If the target DT OPP table is used by multiple devices and they all
>>> create separate instances of 'struct opp_table' from it, then it is
>>> possible that the required_opp_tables entry may be set to the incorrect
>>> sibling device.
>>>
>>> Unfortunately, there is no clear way to initialize the right values
>>> during the initial parsing and we need to do this at a later point of
>>> time.
>>>
>>> Cross check the OPP table again while the genpds are attached and fix
>>> them if required.
>>>
>>> Also add a new API for the genpd core to fetch the device pointer for
>>> the genpd.
>>>
>>> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
>>> Reported-by: Vladimir Lypak <vladimir.lypak@gmail.com>
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218682
>>
>> Did this fall through the cracks? Just wondering, as from here it looks
>> like for about four weeks now nothing happened to fix the regression
>> linked above. But I might have missed something. Or is everybody waiting
>> for a test from the reporter?
> 
> I have chatted a bit with Viresh about this problem offlist, while
> both me and him are/have been on vacations. Sorry for the delay and
> confusion.
> 
> The latest update from my side is that I am working on a solution,
> that aim to remove the entire dev|devm_pm_opp_detach_genpd() API.

That sounds like something that would have to wait for a merge window;
so given the timing I assume this would mean that the earliest point in
time to merge this would be for 6.11-rc1, which is ~2 months away --
plus another 9 or 10 weeks until the fix would reach users.

> Instead, the plan is to move consumer drivers to use
> dev_pm_domain_attach_list() to attach multiple PM domains per device.
> When it comes to hooking up the required-opps-tables/devs, I think
> genpd should be able to manage this during the device attach process.
> In this way, consumer drivers shouldn't need to care about this at
> all.
> 
> That said, I am hoping that $subject patch should not be needed.
> Although, I need a bit more time before I am ready to post a patchset
> for the above.
> 
> What do you think?

Given that the report is already more than a month old now and what I
assumed above (which might be wrong), this makes me wonder: is there a
downside if we apply this patch now, and simply revert this later when
your proper solution is merged? I would assume that is what Linus want
in this case to honor the "no regressions" rule.

Might be something different if this is something like a really odd
corner case we assume nobody (or nearly nobody) will run into in
practice. But as somebody noticed this, I assume that is not the case.

Ciao, Thorsten

>>> Co-developed-by: Vladimir Lypak <vladimir.lypak@gmail.com>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>> V2:
>>> - Fix an `if` condition.
>>> - s/Bugzilla/Closes/ and change ordering.
>>>
>>>  drivers/opp/core.c        | 31 ++++++++++++++++++++++++++++++-
>>>  drivers/pmdomain/core.c   | 10 ++++++++++
>>>  include/linux/pm_domain.h |  6 ++++++
>>>  3 files changed, 46 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>>> index e233734b7220..cb4611fe1b5b 100644
>>> --- a/drivers/opp/core.c
>>> +++ b/drivers/opp/core.c
>>> @@ -2394,7 +2394,8 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
>>>  static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
>>>                       const char * const *names, struct device ***virt_devs)
>>>  {
>>> -     struct device *virt_dev;
>>> +     struct device *virt_dev, *gdev;
>>> +     struct opp_table *genpd_table;
>>>       int index = 0, ret = -EINVAL;
>>>       const char * const *name = names;
>>>
>>> @@ -2427,6 +2428,34 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
>>>                       goto err;
>>>               }
>>>
>>> +             /*
>>> +              * The required_opp_tables parsing is not perfect, as the OPP
>>> +              * core does the parsing solely based on the DT node pointers.
>>> +              * The core sets the required_opp_tables entry to the first OPP
>>> +              * table in the "opp_tables" list, that matches with the node
>>> +              * pointer.
>>> +              *
>>> +              * If the target DT OPP table is used by multiple devices and
>>> +              * they all create separate instances of 'struct opp_table' from
>>> +              * it, then it is possible that the required_opp_tables entry
>>> +              * may be set to the incorrect sibling device.
>>> +              *
>>> +              * Cross check it again and fix if required.
>>> +              */
>>> +             gdev = dev_to_genpd_dev(virt_dev);
>>> +             if (IS_ERR(gdev))
>>> +                     return PTR_ERR(gdev);
>>> +
>>> +             genpd_table = _find_opp_table(gdev);
>>> +             if (!IS_ERR(genpd_table)) {
>>> +                     if (genpd_table != opp_table->required_opp_tables[index]) {
>>> +                             dev_pm_opp_put_opp_table(opp_table->required_opp_tables[index]);
>>> +                             opp_table->required_opp_tables[index] = genpd_table;
>>> +                     } else {
>>> +                             dev_pm_opp_put_opp_table(genpd_table);
>>> +                     }
>>> +             }
>>> +
>>>               /*
>>>                * Add the virtual genpd device as a user of the OPP table, so
>>>                * we can call dev_pm_opp_set_opp() on it directly.
>>> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
>>> index 4215ffd9b11c..c40eda92a85a 100644
>>> --- a/drivers/pmdomain/core.c
>>> +++ b/drivers/pmdomain/core.c
>>> @@ -184,6 +184,16 @@ static struct generic_pm_domain *dev_to_genpd(struct device *dev)
>>>       return pd_to_genpd(dev->pm_domain);
>>>  }
>>>
>>> +struct device *dev_to_genpd_dev(struct device *dev)
>>> +{
>>> +     struct generic_pm_domain *genpd = dev_to_genpd(dev);
>>> +
>>> +     if (IS_ERR(genpd))
>>> +             return ERR_CAST(genpd);
>>> +
>>> +     return &genpd->dev;
>>> +}
>>> +
>>>  static int genpd_stop_dev(const struct generic_pm_domain *genpd,
>>>                         struct device *dev)
>>>  {
>>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>>> index 772d3280d35f..f24546a3d3db 100644
>>> --- a/include/linux/pm_domain.h
>>> +++ b/include/linux/pm_domain.h
>>> @@ -260,6 +260,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>>>  int pm_genpd_init(struct generic_pm_domain *genpd,
>>>                 struct dev_power_governor *gov, bool is_off);
>>>  int pm_genpd_remove(struct generic_pm_domain *genpd);
>>> +struct device *dev_to_genpd_dev(struct device *dev);
>>>  int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
>>>  int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
>>>  int dev_pm_genpd_remove_notifier(struct device *dev);
>>> @@ -307,6 +308,11 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
>>>       return -EOPNOTSUPP;
>>>  }
>>>
>>> +static inline struct device *dev_to_genpd_dev(struct device *dev)
>>> +{
>>> +     return ERR_PTR(-EOPNOTSUPP);
>>> +}
>>> +
>>>  static inline int dev_pm_genpd_set_performance_state(struct device *dev,
>>>                                                    unsigned int state)
>>>  {
> 
> 

