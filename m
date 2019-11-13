Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A532FA055
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 02:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKMBiB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 20:38:01 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:64620 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfKMBiA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2019 20:38:00 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191113013758epoutp02af582a059176fae64bac553d8ab01e30~WlR6MfSeg1436614366epoutp02Y
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 01:37:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191113013758epoutp02af582a059176fae64bac553d8ab01e30~WlR6MfSeg1436614366epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573609078;
        bh=2S9pgnR5Onr6z/xDrnsFOe9XMO2xej4TY+lKfVJhOY0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MHbka8zP7UP5jyPC2/bJsgmOlAMhrGkR0/0otYTKxXWAYW5Mb7VW3yVf36ym8yxdk
         earadt6nAcOOmLG417uMWVK/jKp/VmoRoRFkkCbEXV9h3Tc4wXm5/jZjYIHqfIl5ym
         QfskP8r30oC2DOV17JIo3FhdMZYpBifjNBvsSJiI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191113013757epcas1p4f6ffb7dc4a3c768b45cfb6a5adb0eabe~WlR5hy_hb2286522865epcas1p4p;
        Wed, 13 Nov 2019 01:37:57 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47CS0z2B7dzMqYkc; Wed, 13 Nov
        2019 01:37:55 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.75.04068.37E5BCD5; Wed, 13 Nov 2019 10:37:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191113013754epcas1p19c6ce750ffb6b8f896852b492970bf9c~WlR3BZ7-u1695016950epcas1p1j;
        Wed, 13 Nov 2019 01:37:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191113013754epsmtrp26377045ecb1723cb1a00ab46f3d84ebf~WlR2-zW9K0202802028epsmtrp2s;
        Wed, 13 Nov 2019 01:37:54 +0000 (GMT)
X-AuditID: b6c32a39-f5fff70000000fe4-76-5dcb5e733735
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.33.24756.27E5BCD5; Wed, 13 Nov 2019 10:37:54 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113013754epsmtip1b0b0b6c4426ed6f7a36aa8d2688daa0d~WlR2m4HNZ0181001810epsmtip19;
        Wed, 13 Nov 2019 01:37:54 +0000 (GMT)
Subject: Re: [PATCH v4 5/6] PM / devfreq: imx8m-ddrc: Measure bandwidth with
 perf
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <5c5d4237-c8f1-f59e-272e-84d2a8528054@samsung.com>
Date:   Wed, 13 Nov 2019 10:43:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB702331A22024C6EDB57AC840EE770@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-2"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbUxTZxTHfdr70hIqd0XGY+O2cpdlGQmlBSsPUwxGt90MY0jYzLasYzfl
        Bhr6lt6iuH0YLrw2bMNM3KwiddhZC8mkdIpIwywVERwCC8ysY5LADDGjiB0LOMW1vS7h2++c
        /M85z/88ORKxfIBUSAxmO2czs0aaSMIuDb6WncV/NKpTrzVRKDj0I4lWRkcA+n7yOkB/t/aJ
        0dzdMECXT+pRe2gMR909YQx9E/ARyNt6BUO3b18k0c+f/0Uiz8wyjnxz0zhabv4DR45HF8Qo
        +kUIIPevEyI07TmGo+jFOYAmRt5A4aMeAnWOXSPQrdFJHNUFQiRyBJ8QaH26G0ML/nTUvcIU
        vsC0OjyA6TrTBZilO3Ukc6pmAmNcvirG520imN+n+wmm59xnTHekV8Rci/SLmK+eqJlHg2mM
        f6oBY770ewET9b1YnPJB5a4Kji3jbErOrLeUGczlBXRRSeneUu0OtSZLk4/yaKWZNXEF9L79
        xVlvGoyx9dDKQ6yxKpYqZnmezt69y2apsnPKCgtvL6A5a5nRmm9V8ayJrzKXq/QW0+satTpH
        GxN+XFnhDc1iVuf71TML5/AaMPyWA0glkNoO79eOYg6QJJFTvQA2RZdFQvAQwDr/OhCCfwBs
        XF0jHUCSKHEsJgv5AID1Z4dAvJWcWgLwxt2iOKdSJfBp/VKi0xbqPICu3kAiEFPjEnja3SKK
        qwgqEw4s3CHinEJlwKnVuUQnGbUbDrR9h8UZo16BJx50YvHJadR7cHSFFSTPwZsn5xMSKaWD
        natuPM5iSgXvjTgxgdPhb/PtIoFfgpcXT4vjb4DULQm82n8cCAvYB121i7jAqfD+DT8psAJG
        IwFC4E/hhZshQihuBNA/MP6sIBcOuL8WCZwBr/zbBoRpm2FkpRkX1iWDjfVyQfIy/GV25pl8
        K+xoaCJaAO3c4Me5wYNzgwfnBg8ugHnB85yVN5VzvMaq3fjfPpA4nsz8XjA0tj8IKAmgk2Xw
        7IhOjrOH+COmIIASMb1F1ls9rJPLytgjn3A2S6mtysjxQaCNrfuYWJGmt8RO0Wwv1WhzcnNz
        0XbNDq1GQ6fL9px36+RUOWvnKjnOytn+rxNJpIoaMLiz7fD6wfYTmwojfamrrxaqHK6xnAwF
        8+62Bm2mM+3S8JnkEtNjZXhvIKR/uvNh/uzWqQONeeF7Rdd/GKpu1ndte6fm7ZT6vp5xT/af
        0s4pAxnSNX8rIw9i9bMH9kzWkosfqgJJLZG8tVrDZJi6anrc8VP0eNbRTdKO+QebU02HaYyv
        YDWZYhvP/gf1JHJKUgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUhTYRjHe3c+dlytTpviq5LhyItGlkLEexERRHW6icKCvpateZiWm2Nn
        mlaQRmpbpQWZuDR1rlqbiU5NK0XcNMxP5sdaaRaoJJKaLckKrTYLdvd7/s/vD8/FQ2EiCxFO
        Jat1rFYtT5GQAvyZUxIZoz3dLYsdtcUgx6sGPlro7gLo0UAHQN8KX2Bo/MMIQI3FClTW3keg
        2roRHBW12ElkLXyOo/7+Gj7qvfqZjyzv5wlkH3cTaP7mGIEMP59gyHurHaCHb1w85LbcIZC3
        ZhwgV9deNJJtIZGtr41EPd0DBMppaecjg2OJRMvuWhxN1Yei2gVm9wam0GABTNWDKsDMeXL4
        zP0sF86U29MYu1VPMqPuZpKpM19hamebeEzbbDOPKViKZX46Q5j64Tycya+3AsZrjzy07oRg
        ZyKbkpzOarftOiNIsrZ/xDXG4xnvp8xEFujcbwAUBent0DCzxgAElIh+CaDe9ZQwgKC/eRi8
        5+rAVhwxdDq5FWcGwC93fvB9jpiOh79z53i+RTD9GEBnQzHuGzB6iILXS6ykzxLR0zy4YE/w
        MUlLYeuUx5+vo6Pg8OI48LGQ3gVbS024j3E6Gt77YvNzCH0Mfmr0/HPWw9fFE/48iJZB2+JD
        /6UYvQXmeit4KxwK302U/eONsHGmBLsNxMaAujGgYgyoGAMq5QC3gjBWw6mUKi5OE6dmL2zl
        5CouTa3cqkhV2YH/f6Sbm8CgOcEBaApI1ghhRZdMRMjTuUyVA0AKkwQLmzI6ZSJhojzzIqtN
        TdCmpbCcA0RQuCRUOKl+dVxEK+U69jzLaljt/y2PCgrPApdM39vyDmjch0MjgmMLhsKBdFOl
        fFCx/ytet1uszDHl94g3HSnKyu+ob15yVq/a8dicfW3s7eqTM3ume3VBSVTXwUSX0tu3zVah
        KOueqzbNXa+siNavPTdpMd3QEZ6jV6JsnSfv9se3PdIH70s1qn9Ft147ay05tfrycnxUaf55
        Cc4lyeOkmJaT/wGO9mP2OwMAAA==
X-CMS-MailID: 20191113013754epcas1p19c6ce750ffb6b8f896852b492970bf9c
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191108224023epcas1p43cb02d83f5d9b8d8774405dcea03530f
References: <cover.1573252696.git.leonard.crestez@nxp.com>
        <CGME20191108224023epcas1p43cb02d83f5d9b8d8774405dcea03530f@epcas1p4.samsung.com>
        <a25094eac4c0f740e0e33c04af699b39a4226a08.1573252696.git.leonard.crestez@nxp.com>
        <59f37128-45e8-763d-dd48-32baa864d2a6@samsung.com>
        <VI1PR04MB702331A22024C6EDB57AC840EE770@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

On 11/12/19 10:17 PM, Leonard Crestez wrote:
> On 11.11.2019 07:13, Chanwoo Choi wrote:
>> Hi Leonard,
>>
>> On 11/9/19 7:39 AM, Leonard Crestez wrote:
>>> The imx8m ddrc has a performance monitoring block attached which can
>>> be used to measure bandwidth usage and automatically adjust frequency.
>>>
>>> There is already a perf driver for that block so instead of implementing
>>> a devfreq events driver use the in-kernel perf API to implement
>>> get_dev_status directly.
>>>
>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>> ---
>>>   drivers/devfreq/imx8m-ddrc.c | 153 +++++++++++++++++++++++++++++++++++
>>>   1 file changed, 153 insertions(+)
>>>
>>> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
>>> index 51903fee21a7..6372191f72d7 100644
>>> --- a/drivers/devfreq/imx8m-ddrc.c
>>> +++ b/drivers/devfreq/imx8m-ddrc.c
>>> @@ -11,10 +11,13 @@
>>>   #include <linux/pm_opp.h>
>>>   #include <linux/clk.h>
>>>   #include <linux/clk-provider.h>
>>>   #include <linux/arm-smccc.h>
>>>   
>>> +#include <asm/perf_event.h>
>>> +#include <linux/perf_event.h>
>>> +
>>>   #define IMX_SIP_DDR_DVFS			0xc2000004
>>>   
>>>   /* Values starting from 0 switch to specific frequency */
>>>   #define IMX_SIP_DDR_FREQ_SET_HIGH		0x00
>>>   
>>> @@ -78,10 +81,22 @@ struct imx8m_ddrc {
>>>   	struct clk *dram_alt;
>>>   	struct clk *dram_apb;
>>>   
>>>   	int freq_count;
>>>   	struct imx8m_ddrc_freq freq_table[IMX8M_DDRC_MAX_FREQ_COUNT];
>>> +
>>> +	/* For measuring load with perf events: */
>>> +	struct platform_device *pmu_pdev;
>>> +	struct pmu *pmu;
>>> +
>>> +	struct perf_event_attr rd_event_attr;
>>> +	struct perf_event_attr wr_event_attr;
>>> +	struct perf_event *rd_event;
>>> +	struct perf_event *wr_event;
>>> +
>>> +	u64 last_rd_val, last_rd_ena, last_rd_run;
>>> +	u64 last_wr_val, last_wr_ena, last_wr_run;
>>>   };
>>>   
>>>   static struct imx8m_ddrc_freq *imx8m_ddrc_find_freq(struct imx8m_ddrc *priv,
>>>   						    unsigned long rate)
>>>   {
>>> @@ -245,10 +260,131 @@ static int imx8m_ddrc_get_cur_freq(struct device *dev, unsigned long *freq)
>>>   	*freq = clk_get_rate(priv->dram_core);
>>>   
>>>   	return 0;
>>>   }
>>>   
>>> +static int imx8m_ddrc_get_dev_status(struct device *dev,
>>> +				     struct devfreq_dev_status *stat)
>>> +{
>>> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
>>> +
>>> +	stat->current_frequency = clk_get_rate(priv->dram_core);
>>> +
>>> +	if (priv->rd_event && priv->wr_event) {
>>> +		u64 rd_delta, rd_val, rd_ena, rd_run;
>>> +		u64 wr_delta, wr_val, wr_ena, wr_run;
>>> +
>>> +		rd_val = perf_event_read_value(priv->rd_event,
>>> +					       &rd_ena, &rd_run);
>>> +		wr_val = perf_event_read_value(priv->wr_event,
>>> +					       &wr_ena, &wr_run);
>>> +
>>> +		rd_delta = (rd_val - priv->last_rd_val) *
>>> +			   (rd_ena - priv->last_rd_ena);
>>> +		do_div(rd_delta, rd_run - priv->last_rd_run);
>>> +		priv->last_rd_val = rd_val;
>>> +		priv->last_rd_ena = rd_ena;
>>> +		priv->last_rd_run = rd_run;
>>> +
>>> +		wr_delta = (wr_val - priv->last_wr_val) *
>>> +			   (wr_ena - priv->last_wr_ena);
>>> +		do_div(wr_delta, wr_run - priv->last_wr_run);
>>> +		priv->last_wr_val = wr_val;
>>> +		priv->last_wr_ena = wr_ena;
>>> +		priv->last_wr_run = wr_run;
>>> +
>>> +		/* magic numbers, possibly wrong */
>>> +		stat->busy_time = 4 * (rd_delta + wr_delta);
>>> +		stat->total_time = stat->current_frequency;
>>> +	} else {
>>> +		stat->busy_time = 0;
>>> +		stat->total_time = 0;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int imx8m_ddrc_perf_disable(struct imx8m_ddrc *priv)
>>> +{
>>> +	/* release and set to NULL */
>>> +	if (!IS_ERR_OR_NULL(priv->rd_event))
>>> +		perf_event_release_kernel(priv->rd_event);
>>> +	if (!IS_ERR_OR_NULL(priv->wr_event))
>>> +		perf_event_release_kernel(priv->wr_event);
>>> +	priv->rd_event = NULL;
>>> +	priv->wr_event = NULL;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int imx8m_ddrc_perf_enable(struct imx8m_ddrc *priv)
>>
>> Actually, this function have to call the just function for enabling
>> the bandwidth monitoring instead of writing the detailed something.
>> It looks like that you move the part of the different device driver into here.
> 
> This is the code for enabling bandwith monitoring: it creates perf 
> counters using in-kernel API. The perf api doesn't seem to expose 
> anything else to enable/disable the counter after creation and honestly 
> just create/destroy seems fine.
> 
> As far as I can tell bandwidth monitoring in devfreq is always enabled 
> on probe anyway, no matter which governor is in use. It would be nice if 
> devfreq drivers could receive a callback and dynamically acquire/release 
> monitoring resources only when the ondemand governor is in used.

As you commented, it doesn't matter to keep the enabling state of perf.
Just, I want to say that I think that it is not proper to access
the different device driver directly without any standard subsystem interface.

> 
> Until then this driver will permanently allocate 2 (out of 3) counters 
> in ddr pmu hardware.
> 
>>> +{
>>> +	int ret;
>>> +
>>> +	priv->rd_event_attr.size = sizeof(priv->rd_event_attr);
>>> +	priv->rd_event_attr.type = priv->pmu->type;
>>> +	priv->rd_event_attr.config = 0x2a;
>>> +
>>> +	priv->rd_event = perf_event_create_kernel_counter(
>>> +			&priv->rd_event_attr, 0, NULL, NULL, NULL);
>>> +	if (IS_ERR(priv->rd_event)) {
>>> +		ret = PTR_ERR(priv->rd_event);
>>> +		goto err;
>>> +	}
>>> +
>>> +	priv->wr_event_attr.size = sizeof(priv->wr_event_attr);
>>> +	priv->wr_event_attr.type = priv->pmu->type;
>>> +	priv->wr_event_attr.config = 0x2b;
>>> +
>>> +	priv->wr_event = perf_event_create_kernel_counter(
>>> +			&priv->wr_event_attr, 0, NULL, NULL, NULL);
>>> +	if (IS_ERR(priv->wr_event)) {
>>> +		ret = PTR_ERR(priv->wr_event);
>>> +		goto err;
>>> +	}
>>> +
>>> +	return 0;
>>> +
>>> +err:
>>> +	imx8m_ddrc_perf_disable(priv);
>>> +	return ret;
>>> +}
>>> +
>>> +static int imx8m_ddrc_init_events(struct device *dev,
>>> +				  struct device_node *events_node)
>>
>> ditto.
>>
>>> +{
>>> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
>>> +	struct device_driver *driver;
>>> +
>>> +	/*
>>> +	 * We need pmu->type for perf_event_attr but there is no API for
>>> +	 * mapping device_node to pmu. Fetch private data for imx-ddr-pmu and
>>> +	 * cast that to a struct pmu instead.
>>> +	 */
>>> +	priv->pmu_pdev = of_find_device_by_node(events_node);
>>> +	if (!priv->pmu_pdev)
>>> +		return -EPROBE_DEFER;
>>> +	driver = priv->pmu_pdev->dev.driver;
>>> +	if (!driver)
>>> +		return -EPROBE_DEFER;
>>> +	if (strcmp(driver->name, "imx-ddr-pmu")) {
>>> +		dev_warn(dev, "devfreq-events node %pOF has unexpected driver %s\n",
>>> +				events_node, driver->name);
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	priv->pmu = platform_get_drvdata(priv->pmu_pdev);
>>
>> It seems that you access the different device driver without
>> any standard interface from some linux kernel subsystem.
>>
>> For the communication or control between different device drivers,
>> we have to use the standard interface instead of direct access or call.
>> I think that it make it too tightly coupled driver between them.
>>
>> So, I developed the devfreq-event subsystem for this reason
>> in order to remove the non-standard direct access to other device driver.
>>
>> Unfortunately, I can't agree this approach. I don't prefer to use
>> the direct access of other device driver(imx-ddr-pmu). You need to
>> use standard interface provided from subsystem. or You need to make
>> the new device driver with devfreq-event subsystem.
> 
> This could be cleaned-up by adding a new API to "fetch struct pmu* by 
> struct device_node*" as available for many other subsystems.

OK. I'll expect the next version with keeping the rule without
any direct access between two device drivers.

 The perf 
> api is otherwise standard/generic and has a few other in-kernel users.

> 
> The perf driver for DDR PMU is already functional and useful for 
> profiling and reusing it seem very worthwhile. If you're suggesting I 
> implemented an unrelated "devfreq-event" driver then how would it get 
> probed? There's only one PMU node in DT.

No, I don't force to develop the new devfreq-event instead of exiting perf driver.
As I said already,I think that it is not proper to access the different device driver
directly without any standard subsystem interface.

The following style access is not safe. Any device driver might change
the platform data of the other device driver. 
	priv->pmu = platform_get_drvdata(priv->pmu_pdev);

If you support this patch with standard subsystem interface, I'm OK.
Just, I don't want to access the data of different device driver.

> 
> I wouldn't mind to delay the monitoring part into a second series.
> 
>>> +	if (!priv->pmu) {
>>> +		dev_err(dev, "devfreq-events device missing private data\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	dev_dbg(dev, "events from pmu %s\n", priv->pmu->name);
>>> +
>>> +	return imx8m_ddrc_perf_enable(priv);
>>> +}
>>> +
>>>   static int imx8m_ddrc_init_freq_info(struct device *dev)
>>>   {
>>>   	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
>>>   	struct arm_smccc_res res;
>>>   	int index;
>>> @@ -328,17 +464,23 @@ static int imx8m_ddrc_check_opps(struct device *dev)
>>>   	return 0;
>>>   }
>>>   
>>>   static void imx8m_ddrc_exit(struct device *dev)
>>>   {
>>> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
>>> +
>>> +	imx8m_ddrc_perf_disable(priv);
>>> +	platform_device_put(priv->pmu_pdev);
>>> +
>>>   	dev_pm_opp_of_remove_table(dev);
>>>   }
>>>   
>>>   static int imx8m_ddrc_probe(struct platform_device *pdev)
>>>   {
>>>   	struct device *dev = &pdev->dev;
>>>   	struct imx8m_ddrc *priv;
>>> +	struct device_node *events_node;
>>>   	const char *gov = DEVFREQ_GOV_USERSPACE;
>>>   	int ret;
>>>   
>>>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>>   	if (!priv)
>>> @@ -350,10 +492,19 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
>>>   	if (ret) {
>>>   		dev_err(dev, "failed to init firmware freq info: %d\n", ret);
>>>   		return ret;
>>>   	}
>>>   
>>> +	events_node = of_parse_phandle(dev->of_node, "devfreq-events", 0);
>>> +	if (events_node) {
>>> +		ret = imx8m_ddrc_init_events(dev, events_node);
>>> +		of_node_put(events_node);
>>> +		if (ret)
>>> +			goto err;
>>> +		gov = DEVFREQ_GOV_SIMPLE_ONDEMAND;
>>> +	}
>>> +
>>>   	priv->dram_core = devm_clk_get(dev, "core");
>>>   	priv->dram_pll = devm_clk_get(dev, "pll");
>>>   	priv->dram_alt = devm_clk_get(dev, "alt");
>>>   	priv->dram_apb = devm_clk_get(dev, "apb");
>>>   	if (IS_ERR(priv->dram_core) ||
>>> @@ -390,10 +541,12 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
>>>   	}
>>>   
>>>   	return 0;
>>>   
>>>   err:
>>> +	imx8m_ddrc_perf_disable(priv);
>>> +	platform_device_put(priv->pmu_pdev);
>>>   	dev_pm_opp_of_remove_table(dev);
>>>   	return ret;
>>>   }
>>>   
>>>   static const struct of_device_id imx8m_ddrc_of_match[] = {
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
