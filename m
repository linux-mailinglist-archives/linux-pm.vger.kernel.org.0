Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2707C288
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 15:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfGaNAn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 09:00:43 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57721 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbfGaNAn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 09:00:43 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190731130041euoutp011cddbabe354d08e8ff9ab226b4c838e9~2f3COatgp0881108811euoutp017
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 13:00:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190731130041euoutp011cddbabe354d08e8ff9ab226b4c838e9~2f3COatgp0881108811euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564578042;
        bh=JsNx/ZHEmr3Y2W5flkOZT9mCwHMMMBpVVzqBmYmdqj4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oqDRjYBV6J1cP6UbBuVFUx5Gt+shwNuxvDhyeEez65yPJQqITEweeI3xRmwESD08m
         9mhAVuGElUIyBWong9SxVVn5gG5gYsn05NzEem8Da47r9K/ns1/qM15x9FmQGski4S
         PuzKPGlwStnmx3R1YzIlchdM/ihUKuisKEnwjG/0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190731130041eucas1p19e84a77affa1a2061579443d5423efb3~2f3BbLg3y1122111221eucas1p1o;
        Wed, 31 Jul 2019 13:00:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 71.D1.04298.8F0914D5; Wed, 31
        Jul 2019 14:00:40 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190731130040eucas1p2859eec7357e99337050852d040001a4c~2f3AvP8YZ3273932739eucas1p2o;
        Wed, 31 Jul 2019 13:00:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190731130040eusmtrp2eadfe3c7214c3ff3e30fd51299504523~2f3AululZ0511305113eusmtrp2v;
        Wed, 31 Jul 2019 13:00:40 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-4f-5d4190f80d53
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F0.1A.04146.8F0914D5; Wed, 31
        Jul 2019 14:00:40 +0100 (BST)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20190731130039eusmtip1d0339c5e75c212b63d4c8db640cbc5eb~2f3AFK48M2353623536eusmtip1P;
        Wed, 31 Jul 2019 13:00:39 +0000 (GMT)
Message-ID: <bda10bcc66aae96355e74c4739229d72bcc95b0d.camel@partner.samsung.com>
Subject: Re: [RFC PATCH 01/11] devfreq: exynos-bus: Extract
 exynos_bus_profile_init()
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com,
        =?UTF-8?Q?Bart=C5=82omiej_?= =?UTF-8?Q?=C5=BBo=C5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>
Date:   Wed, 31 Jul 2019 15:00:38 +0200
In-Reply-To: <20190724190741.GD14346@kozik-lap>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djP87o/JjjGGpzfZGyxccZ6VovrX56z
        Wsw/co7V4srX92wW0/duYrOYdH8Ci8X58xvYLTY9vsZqcXnXHDaLz71HGC1mnN/HZLH2yF12
        i9uNK9gsZkx+yebA57FpVSebx51re9g87ncfZ/LYvKTeo2/LKkaPz5vkAtiiuGxSUnMyy1KL
        9O0SuDKeLO5kK9gvWLH9cgtbA2MTXxcjJ4eEgInE1r4mpi5GLg4hgRWMEmcOfmCBcL4wStz8
        sIMNwvnMKLHg+gxGmJYn35aygthCAssZJWbfEIQoesYosbLtBQtIglcgQOLE6U5mEFtYIFzi
        5bIvbCA2m4C7xL/nV8CaRQQ0Ja7//c4K0swscIBZ4uDeqewgCRYBVYlNP6aAFXEK6EvsWPaK
        GWKzjsTbU31ACziAFghK/N0hDBJmFpCXaN46mxlkjoTALXaJQ493sUDUu0jMu30FqldY4tXx
        LewQtozE/53zmSDsYomnO++zQjQ3MEpsWnYEqsFa4vDxi6wgy5iBLl2/Sx8i7Chx5PcpZpCw
        hACfxI23ghA38ElM2jYdKswr0dEmBGFqSSz4HQ3RKCHRtPoa1GwPif371jFNYFSchfDLLCS/
        zELYuoCReRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZg0jr97/inHYxfLyUdYhTgYFTi
        4T3R6RgrxJpYVlyZe4hRgoNZSYR3sbh9rBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeaoYH0UIC
        6YklqdmpqQWpRTBZJg5OqQZGDvkp3oLrF+0/eXO718nG2qsRn+w66mxT5rPaXmtr4O2vMtuY
        m3vTJuVe+8qr/8/aWfm5/EvdN/VxxqSEXZtCgmNuex3aWdmfoWz5Z+/yksj/2oeOFNgpMLv2
        uq2YET57/wSjVy3/Te5Ixf/oefXyDfuuCGfxjKn5j+t1Fe6XbXcJ8vefN/GZEktxRqKhFnNR
        cSIAKDdUblYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7o/JjjGGtw5wW+xccZ6VovrX56z
        Wsw/co7V4srX92wW0/duYrOYdH8Ci8X58xvYLTY9vsZqcXnXHDaLz71HGC1mnN/HZLH2yF12
        i9uNK9gsZkx+yebA57FpVSebx51re9g87ncfZ/LYvKTeo2/LKkaPz5vkAtii9GyK8ktLUhUy
        8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DKeLO5kK9gvWLH9cgtb
        A2MTXxcjJ4eEgInEk29LWbsYuTiEBJYySuxsv84OkZCQ+Lj+BiuELSzx51oXG0TRE0aJyZM2
        M4IkeAUCJE6c7mQGsYUFwiVeLvvCBmKzCbhL/Ht+BaxZREBT4vrf72AbmAUOMUusO9ANlmAR
        UJXY9GMKmM0poC+xY9krZogNXxklLj9sApvKDNTduv031Ek6Em9P9bF0MXIAbRaU+LtDGKJE
        XqJ562zmCYyCs5B0zEKomoWkagEj8ypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAmNx27Ofm
        HYyXNgYfYhTgYFTi4T3R6RgrxJpYVlyZe4hRgoNZSYR3sbh9rBBvSmJlVWpRfnxRaU5q8SFG
        U6B/JjJLiSbnA9NFXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkG
        RkOLbx4M2RXmzson/N3W898OXPj/o/9UvSNr3Yy74iLeuqzKMbMXTaxcvdMytLXz4d4rMftj
        uAXCUgp/3Mq+KFsR26VdUfKhm0UsQvvC3yr1EH/GGq8FT34dX+MpEddfwZLc8UK/U4G7Kj3a
        yt/x5S5L16qP2yoOzoi+fXlS/durvOd+r1RWYinOSDTUYi4qTgQAuqR9dt8CAAA=
X-CMS-MailID: 20190731130040eucas1p2859eec7357e99337050852d040001a4c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723122022eucas1p1266d90873d564894bd852c20140f8474
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723122022eucas1p1266d90873d564894bd852c20140f8474
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <CGME20190723122022eucas1p1266d90873d564894bd852c20140f8474@eucas1p1.samsung.com>
        <20190723122016.30279-2-a.swigon@partner.samsung.com>
        <20190724190741.GD14346@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, 2019-07-24 at 21:07 +0200, Krzysztof Kozlowski wrote:
> On Tue, Jul 23, 2019 at 02:20:06PM +0200, Artur Świgoń wrote:
> > This patch adds a new static function, exynos_bus_profile_init(), extracted
> > from exynos_bus_probe().
> > 
> > Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> > ---
> >  drivers/devfreq/exynos-bus.c | 106 ++++++++++++++++++++---------------
> >  1 file changed, 60 insertions(+), 46 deletions(-)
> > 
> > diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> > index d9f377912c10..d8f1efaf2d49 100644
> > --- a/drivers/devfreq/exynos-bus.c
> > +++ b/drivers/devfreq/exynos-bus.c
> > @@ -372,12 +372,69 @@ static int exynos_bus_parse_of(struct device_node *np,
> >  	return ret;
> >  }
> >  
> > +static int exynos_bus_profile_init(struct exynos_bus *bus,
> > +				   struct devfreq_dev_profile *profile)
> > +{
> > +	struct device *dev = bus->dev;
> > +	struct devfreq_simple_ondemand_data *ondemand_data;
> > +	int ret;
> > +
> > +	/* Initialize the struct profile and governor data for parent device */
> > +	profile->polling_ms = 50;
> > +	profile->target = exynos_bus_target;
> > +	profile->get_dev_status = exynos_bus_get_dev_status;
> > +	profile->exit = exynos_bus_exit;
> > +
> > +	ondemand_data = devm_kzalloc(dev, sizeof(*ondemand_data), GFP_KERNEL);
> > +	if (!ondemand_data) {
> > +		ret = -ENOMEM;
> > +		goto err;
> 
> Just return proper error code. Less lines, obvious code since you do not
> have any cleanup in error path.

I was advised to avoid modifying code being moved (in one patch). I do make
changes in these places in patch 04/11, i.e. change the original label 'err' to
'out'. What's your opinion on making the proposed changes to patches 01 and 02
(s/goto err/return ret/) in patch 04 instead?

> > +
> > +	/* Register opp_notifier to catch the change of OPP  */
> > +	ret = devm_devfreq_register_opp_notifier(dev, bus->devfreq);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to register opp notifier\n");
> > +		goto err;
> 
> The same - return err.
> 
> Best regards,
> Krzysztof

Best regards,
-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


