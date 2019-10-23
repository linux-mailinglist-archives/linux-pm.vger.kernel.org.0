Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B19CE1DB0
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 16:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390333AbfJWOGu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 10:06:50 -0400
Received: from mail-eopbgr50075.outbound.protection.outlook.com ([40.107.5.75]:56033
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389253AbfJWOGt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Oct 2019 10:06:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3GXOFmGqfM0tBDZ7wZ5EPLqlh6l5E8Jn6JjKj4LLwUkDE8agqbo7M1P1Gt/7vexcyYxqb+AXHZe8CFQBGuSJMJVt6Ezo8xTVU3P5V+aatgrAoD5kQcYwOYaaY+4JXJEHERzLtpm28nK6h+nIufnEFtY+E6QMqFizO3zUjdlPc4P9GsvCfgcn+PukQZCjXkyhEgquixvIKoZF2SKeBALiDwoulqEvJTUDFY6g3BEsnOC8Bh60TAuhbdhBDjyZ4Bwf4MUpFfp1nqtAk4QKl7qj4Axbhmhdj/oMEpWVwWM1NYFlrfmjt1Y5LNDiQ6ZLW0jTCCugpjh/nn4BkCAflJb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBej+x1VBKMGu0cXYJJanBXdOoMNnawUUbmBpvDmc0w=;
 b=Mpmuo8y5XWOS6q7OyCCgNNUKjEQJs9aFXqdf3jF9dcyldN9JSS77ug7TIs+tK4jyvLnu23x6T/YT8TM2Mt3EcagyMGCMd0US0nHue71EmT5BvWfX4gwE585E4CQQ67q/Np3dg5NkyQE1SN/GzciexOLcDnxi4njA6RgWpyC6R8E9yPK5vl2JRkYgpaI0kbvgaPg9TDeDd4ViKReJ4rYkNFqLSX2kSQgbGUggfEHoErO8iD3Supeb0Pps7x3fWfsWFu3fg2Q1H34iPUvOkLPQQsgCxkAgSrMwcFxPiSExwP/seBWnmKaoKuNuz8UgpSfkbBKueXUzZlF97p6teX/1kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBej+x1VBKMGu0cXYJJanBXdOoMNnawUUbmBpvDmc0w=;
 b=CGaTjMWesygoYFlSquzn0apY08J5/5zyOKnTh6zLmSx5A2OJcp7XvJbdTuwGt7efpexn9GoNfbNw+8O0eBOss2MQVuatuANezZ1FcqPx3eGNrX5J/ES+y6GslUF1JrZAa+rQezCaoQynEkGCJUdziULHaRd2H6jKVbsXnkCQ6gQ=
Received: from AM7PR04MB7015.eurprd04.prod.outlook.com (52.135.57.19) by
 AM7PR04MB6855.eurprd04.prod.outlook.com (10.141.173.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Wed, 23 Oct 2019 14:06:41 +0000
Received: from AM7PR04MB7015.eurprd04.prod.outlook.com
 ([fe80::3924:7adb:47f2:2ece]) by AM7PR04MB7015.eurprd04.prod.outlook.com
 ([fe80::3924:7adb:47f2:2ece%7]) with mapi id 15.20.2367.022; Wed, 23 Oct 2019
 14:06:40 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 0/8] PM / devfreq: Add dev_pm_qos support
Thread-Topic: [PATCH v9 0/8] PM / devfreq: Add dev_pm_qos support
Thread-Index: AQHVeVcfE84n3PyghE+MA+tYDqGMmw==
Date:   Wed, 23 Oct 2019 14:06:40 +0000
Message-ID: <AM7PR04MB70154D3BA0D6402A9C9BE6A0EE6B0@AM7PR04MB7015.eurprd04.prod.outlook.com>
References: <cover.1570044052.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ca47231-75ff-4b6e-b226-08d757c23a52
x-ms-traffictypediagnostic: AM7PR04MB6855:|AM7PR04MB6855:
x-ms-exchange-purlcount: 11
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB685517937604CFE06B7AE1F2EE6B0@AM7PR04MB6855.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(33656002)(256004)(14444005)(6506007)(316002)(102836004)(53546011)(99286004)(446003)(7736002)(26005)(7696005)(76176011)(6116002)(186003)(66066001)(476003)(3846002)(486006)(305945005)(44832011)(71190400001)(2906002)(71200400001)(110136005)(54906003)(966005)(14454004)(6436002)(64756008)(25786009)(76116006)(55016002)(9686003)(229853002)(6306002)(66476007)(91956017)(66446008)(86362001)(66946007)(66556008)(7416002)(74316002)(5660300002)(8936002)(81166006)(478600001)(8676002)(81156014)(52536014)(45080400002)(6246003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR04MB6855;H:AM7PR04MB7015.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wSDPiSgVbtJLLlQT/f7yaFvb+rCqHqBY62482lv7PHvHg0fCHWHTcFhhdiyMLeS70woeRVKm/GEvvwIRT+n7MOLTa55paMagoYdjQ4+Cw2dJ3RojqIHUFyqvlpoBt6Zl6DZ53Sow7rANNrPWbxPa0AoZQz6QkvP/vyKzlvgsVS13lb0Z3xVRHMzWcNe1CCxAGEwtRoxU5i0fz8Yc2Da7SUEBSGBBHWl+2UQr4I89147Wvmpj1ASvy330KGZ+ryj0qXHetyOL67luyIO69IwLj+U6p/G1uykTNNf1VHwZqwPcavfPvgIQUb/SdGysEBictmIpYz1zZtx3qNwkTZnUE8xXoQ26X6rfzC7r9UC3Paitj58mvf5I6QCVcenT6Gojck/vj9kDx+rrTefOqfPPIrSfC2vZvKa5b/kyHNI53X1LclAdiCUJ64FRpiXQq+2aZLO/0urreXMtPLMDi06IeNfF8RR37gAbWr9SILaQC3w=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca47231-75ff-4b6e-b226-08d757c23a52
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 14:06:40.8859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yqtio9gMsBFSneTByYGClpmX0vZevIK7Nu/yIyp4c/1zyaH2a+5zMLV9wgtvq7wKDkLsxwk/ispXM3Sc6ZpHgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6855
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019-10-02 10:25 PM, Leonard Crestez wrote:=0A=
> Add dev_pm_qos notifiers to devfreq core in order to support frequency=0A=
> limits via dev_pm_qos_add_request.=0A=
> =0A=
> Unlike the rest of devfreq the dev_pm_qos frequency is measured in Khz,=
=0A=
> this is consistent with current dev_pm_qos usage for cpufreq and=0A=
> allows frequencies above 2Ghz (pm_qos expresses limits as s32).=0A=
> =0A=
> Like with cpufreq the handling of min_freq/max_freq is moved to the=0A=
> dev_pm_qos mechanism. Constraints from userspace are no longer clamped on=
=0A=
> store, instead all values can be written and we only check against OPPs i=
n a=0A=
> new devfreq_get_freq_range function. This is consistent with the design o=
f=0A=
> dev_pm_qos.=0A=
> =0A=
> Notifiers from pm_qos are executed under a single global dev_pm_qos_mtx a=
nd=0A=
> need to take devfreq->lock. Notifier registration takes the same dev_pm_q=
os_mtx=0A=
> so in order to prevent lockdep warnings it must be done outside devfreq->=
lock.=0A=
> Current devfreq_add_device does all initialization under devfreq->lock an=
d that=0A=
> needs to be relaxed.=0A=
> =0A=
> Some of first patches in the series are bugfixes and cleanups, they could=
 be=0A=
> applied separately.=0A=
=0A=
Hello,=0A=
=0A=
This series was posted a few ago and all patches have been =0A=
reviewed/tested-by multiple people. Possible minor hangups:=0A=
=0A=
1) Matthias found it confusing that min/max_freq in sysfs changes =0A=
on-the-fly. This is not a behavior change and I believe a decent =0A=
workaround would be to implement separate user_min/max_freq files from =0A=
which userspace will always read back the contraints it has written.=0A=
=0A=
2) There was an objection to removing devm from two allocs in PATCH 4. I =
=0A=
believe current solution is acceptable but a possible alternative would =0A=
be to split device_register into device_initialize and device_add: this =0A=
should allow devm sooner.=0A=
Link: https://patchwork.kernel.org/patch/11158385/#22902151=0A=
=0A=
Let me know if you think I should implement the options above and resend.=
=0A=
=0A=
The bigger problem is that DEV_PM_QOS_MIN/MAX_FREQUENCY was removed from =
=0A=
pm core because only user (cpufreq) was refactored to use a new =0A=
interface on top of cpufreq_policy. Links to discussion:=0A=
     https://patchwork.kernel.org/cover/11193021/=0A=
 =0A=
https://lore.kernel.org/linux-pm/VI1PR04MB7023DF47D046AEADB4E051EBEE680@VI1=
PR04MB7023.eurprd04.prod.outlook.com/T/#u=0A=
=0A=
I believe there is still significant value in supporting min/max =0A=
frequency requests on a per-target-device basis. This makes much more =0A=
sense for devfreq that for cpufreq because the whole point of devfreq is =
=0A=
scaling arbitrary independent devices.=0A=
=0A=
> ---=0A=
> Changes since v8:=0A=
> * Fix incorrectly reading qos max twice in get_freq_range.=0A=
> * Make devfreq_notifier_call set scaling_max_freq to ULONG_MAX instead of=
 0 on=0A=
> error. This avoids special-casing this in get_freq_range.=0A=
> * Add a fix for devfreq_notifier_call returning -errno.=0A=
> * Replace S32_MAX with PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE. This seems cle=
aner=0A=
> and avoids overflow when multiplying S32_MAX with 1000 on 32bit platforms=
. It=0A=
> overflowed to 0xfffffc18 hz so it was mostly safe anyway.=0A=
> * Warn when encountering errors on cleanup (but continue).=0A=
> * Incorporate other smaller comment and printk adjustments from review.=
=0A=
> Link to v8:=0A=
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
work.kernel.org%2Fcover%2F11158383%2F&amp;data=3D02%7C01%7Cleonard.crestez%=
40nxp.com%7Ca6b53046361642d0fd5708d7476e40e4%7C686ea1d3bc2b4c6fa92cd99c5c30=
1635%7C0%7C0%7C637056411174276846&amp;sdata=3DYKKW1RJl1YArhtjlA859DeRxys4d4=
iiB%2FQIz3Nl8OtU%3D&amp;reserved=3D0=0A=
> =0A=
> Changes since v7:=0A=
> * Only #define HZ_PER_KHZ in patch where it's used.=0A=
> * Drop devfreq_ prefix for some internal functions.=0A=
> * Improve qos update error message.=0A=
> * Remove some unnecessary comments.=0A=
> * Collect reviews=0A=
> Link to v7: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Fpatchwork.kernel.org%2Fcover%2F11157649%2F&amp;data=3D02%7C01%7Cleon=
ard.crestez%40nxp.com%7Ca6b53046361642d0fd5708d7476e40e4%7C686ea1d3bc2b4c6f=
a92cd99c5c301635%7C0%7C0%7C637056411174276846&amp;sdata=3D0s6mH192c3dvDlfrF=
EVdqdMqoFRM4QJiLZiRg4c89nQ%3D&amp;reserved=3D0=0A=
> =0A=
> Changes since v6:=0A=
> * Don't return errno from devfreq_qos_notifier_call, return NOTIFY_DONE=
=0A=
> and print the error.=0A=
> * More spelling and punctuation nits=0A=
> Link to v6: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Fpatchwork.kernel.org%2Fcover%2F11157201%2F&amp;data=3D02%7C01%7Cleon=
ard.crestez%40nxp.com%7Ca6b53046361642d0fd5708d7476e40e4%7C686ea1d3bc2b4c6f=
a92cd99c5c301635%7C0%7C0%7C637056411174276846&amp;sdata=3D6hcaCgESymHhCk5Ub=
FC182FrgFVdJdDoorAJhZXKuTg%3D&amp;reserved=3D0=0A=
> =0A=
> Changes since v5:=0A=
> * Drop patches which are not strictly related to PM QoS.=0A=
> * Add a comment explaining why devfreq_add_device needs two cleanup paths=
.=0A=
> * Remove {} for single line.=0A=
> * Rename {min,max}_freq_req to user_{min,max}_freq_req=0A=
> * Collect reviews=0A=
> Link to v5: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Fpatchwork.kernel.org%2Fcover%2F11149497%2F&amp;data=3D02%7C01%7Cleon=
ard.crestez%40nxp.com%7Ca6b53046361642d0fd5708d7476e40e4%7C686ea1d3bc2b4c6f=
a92cd99c5c301635%7C0%7C0%7C637056411174276846&amp;sdata=3DoDuaTI7bpOlCEs9mF=
RgY5eUvGX%2FtpP6m0U5t4SYNKaw%3D&amp;reserved=3D0=0A=
> =0A=
> Changes since v4:=0A=
> * Move more devfreq_add_device init ahead of device_register.=0A=
> * Make devfreq_dev_release cleanup devices not yet in devfreq_list. This =
is=0A=
> simpler than previous attempt to add to devfreq_list sonner.=0A=
> * Take devfreq->lock in trans_stat_show=0A=
> * Register dev_pm_opp notifier on devfreq parent dev (which has OPPs)=0A=
> Link to v4: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Fpatchwork.kernel.org%2Fcover%2F11114657%2F&amp;data=3D02%7C01%7Cleon=
ard.crestez%40nxp.com%7Ca6b53046361642d0fd5708d7476e40e4%7C686ea1d3bc2b4c6f=
a92cd99c5c301635%7C0%7C0%7C637056411174276846&amp;sdata=3DItIVLxJZVOpO2XL2M=
BqONWLQ1lHFu2gA7GC1yb%2BQgEE%3D&amp;reserved=3D0=0A=
> =0A=
> Changes since v3:=0A=
> * Cleanup locking and error-handling in devfreq_add_device=0A=
> * Register notifiers after device registration but before governor start=
=0A=
> * Keep the initialization of min_req/max_req ahead of device_register=0A=
> because it's used for sysfs handling=0A=
> * Use HZ_PER_KHZ instead of 1000=0A=
> * Add kernel-doc comments=0A=
> * Move OPP notifier to core=0A=
> Link to v3: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Fpatchwork.kernel.org%2Fcover%2F11104061%2F&amp;data=3D02%7C01%7Cleon=
ard.crestez%40nxp.com%7Ca6b53046361642d0fd5708d7476e40e4%7C686ea1d3bc2b4c6f=
a92cd99c5c301635%7C0%7C0%7C637056411174276846&amp;sdata=3DunedjnBbjVtifB8ko=
Q0B8eOjqwCnnAeqHGI8QYuH%2Fv4%3D&amp;reserved=3D0=0A=
> =0A=
> Changes since v2:=0A=
> * Handle sysfs via dev_pm_qos (in separate patch)=0A=
> * Add locking to {min,max}_freq_show=0A=
> * Fix checkpatch issues (long lines etc)=0A=
> Link to v2: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Fpatchwork.kernel.org%2Fpatch%2F11084279%2F&amp;data=3D02%7C01%7Cleon=
ard.crestez%40nxp.com%7Ca6b53046361642d0fd5708d7476e40e4%7C686ea1d3bc2b4c6f=
a92cd99c5c301635%7C0%7C0%7C637056411174276846&amp;sdata=3DboHOmdwyUhKlmk7F3=
X8oYbLq1MvR4dQWlF14I0AXXes%3D&amp;reserved=3D0=0A=
> =0A=
> Changes since v1:=0A=
> * Add doxygen comments for min_nb/max_nb=0A=
> * Remove notifiers on error/cleanup paths. Keep gotos simple by relying o=
n=0A=
> dev_pm_qos_remove_notifier ignoring notifiers which were not added.=0A=
> Link to v1: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Fpatchwork.kernel.org%2Fpatch%2F11078475%2F&amp;data=3D02%7C01%7Cleon=
ard.crestez%40nxp.com%7Ca6b53046361642d0fd5708d7476e40e4%7C686ea1d3bc2b4c6f=
a92cd99c5c301635%7C0%7C0%7C637056411174276846&amp;sdata=3DDZlQAKLqQc4Q46a7v=
%2FtEBexsp1jDSLB8yuZcLXPEHl4%3D&amp;reserved=3D0=0A=
> =0A=
> Leonard Crestez (8):=0A=
>    PM / devfreq: Don't fail devfreq_dev_release if not in list=0A=
>    PM / devfreq: Fix devfreq_notifier_call returning errno=0A=
>    PM / devfreq: Set scaling_max_freq to max on OPP notifier error=0A=
>    PM / devfreq: Move more initialization before registration=0A=
>    PM / devfreq: Don't take lock in devfreq_add_device=0A=
>    PM / devfreq: Introduce get_freq_range helper=0A=
>    PM / devfreq: Add PM QoS support=0A=
>    PM / devfreq: Use PM QoS for sysfs min/max_freq=0A=
> =0A=
>   drivers/devfreq/devfreq.c | 310 ++++++++++++++++++++++++++------------=
=0A=
>   include/linux/devfreq.h   |  14 +-=0A=
>   2 files changed, 224 insertions(+), 100 deletions(-)=0A=
> =0A=
=0A=
