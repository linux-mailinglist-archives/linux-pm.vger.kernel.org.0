Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B95C51A4582
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 13:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgDJLMo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 07:12:44 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:44013 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725897AbgDJLMo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 07:12:44 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id D0C895808B7;
        Fri, 10 Apr 2020 07:12:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 10 Apr 2020 07:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=luisgerhorst.de;
         h=references:from:to:cc:subject:in-reply-to:date:message-id
        :mime-version:content-type; s=mesmtp; bh=1XCTRzA4r6t+aW/YmemVZF7
        K9mMd/HGoO3EIq2+dA90=; b=qIrPPVsbiwtiPCG914yDDwQbRVGekh653wn5tFg
        3OXdht3GDey5g1KxO9bQPKJBaZjXrLahuzs7uwHaDn1hha4c8tqr9U6h/enmMfmq
        axrVJWAkDeXqxnz5S/s0WX+23JNsmfvxG76MaCu5yoZ/10otB8aw6fJY8I0RJhAL
        UKCE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=1XCTRz
        A4r6t+aW/YmemVZF7K9mMd/HGoO3EIq2+dA90=; b=W9Z+DKjhWSrSdyvjUXQWV0
        Ht2PBs1Ju8IyieMn6zSkkE0Ul7b4auQXJoekqKJj2FzKU9A+TGuBoFK1SeMMbtzb
        8oMu2rI+B4LzmSkiLSgoieRYIg+B8B0W2HubEz8VgtrlMAXtwwV8LwPnsaNl7ENf
        Hnjisw0YwgMkCsP9gyq9jSxPZWrZ9Ts2HPNybosCeGMKZtC5AH9R3c92CP8iSrSH
        gHS5Yf6zBUWVLj0ZbW7UWf0jF0G8RyBbIZtZRddWT5nYI7Y5ITHyhHNZMoDcYH6U
        Tdhl71Pqk4drxYS2/9BHw9I+ui37vmZMPZYDw+naFkx8jWWMgcUvkw4fFivbpqgw
        ==
X-ME-Sender: <xms:o1SQXtej93cVqf0lMq7BjSBnI80YT6WTnh_bM3bafOgyIiQWYNJntw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrvddvgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpehffgfhvffujgffkfggtgesthdtredttdertdenucfhrhhomhepnfhuihhsucfi
    vghrhhhorhhsthcuoehlihhnuhigqdhkvghrnhgvlheslhhuihhsghgvrhhhohhrshhtrd
    guvgeqnecukfhppeelvddruddujedrudefiedrkeeknecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomheplhhinhhugidqkhgvrhhnvghlsehluhhish
    hgvghrhhhorhhsthdruggv
X-ME-Proxy: <xmx:o1SQXsJqEEpdAVlBBNOrPjECiypCvsioWJAkkkqB7OV1k6G1cJ037Q>
    <xmx:o1SQXm3GbM5jjQeq5Fw3vlWvqURZgDtwUCKygupmqpZPjSWL5fF5KQ>
    <xmx:o1SQXlY0lL6nr4XO4VhiScv6QkQfeTRa26Q3bZiNQCcnAlci-1NBaA>
    <xmx:qlSQXgnwI9ZSlZ3EtewA6ucmkah78uuNHQkFyCGi-HgqJe16QWXm_g>
Received: from luis-debian.fastmail.com (unknown [92.117.136.88])
        by mail.messagingengine.com (Postfix) with ESMTPA id DA33E3280060;
        Fri, 10 Apr 2020 07:12:29 -0400 (EDT)
References: <20200410084210.24932-1-lukasz.luba@arm.com> <20200410084210.24932-5-lukasz.luba@arm.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Luis Gerhorst <linux-kernel@luisgerhorst.de>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, qperret@google.com, bsegall@google.com,
        mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, kernel@pengutronix.de, khilman@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org, mka@chromium.org
Subject: Re: [PATCH v6 04/10] PM / EM: add support for other devices than CPUs in Energy Model
In-reply-to: <20200410084210.24932-5-lukasz.luba@arm.com>
Date:   Fri, 10 Apr 2020 13:12:28 +0200
Message-ID: <87ftdboaqr.fsf@luis-debian.luis-debian-domain>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Lukasz Luba writes:

> +/**
> + * em_dev_unregister_perf_domain() - Unregister Energy Model 
> (EM) for a device
> + * @dev		: Device for which the EM is registered
> + *
> + * Try to unregister the EM for the specified device (it checks 
> current
> + * reference counter). The EM for CPUs will not be freed.
> + */
> +void em_dev_unregister_perf_domain(struct device *dev)
> +{
> +	struct em_device *em_dev, *tmp;
> +
> +	if (IS_ERR_OR_NULL(dev))
> +		return;
> +
> +	/* We don't support freeing CPU structures in hotplug */
> +	if (_is_cpu_device(dev)) {
> +		dev_dbg_once(dev, "EM: the structures are not going to be 
> removed\n");
> +		return;
> +	}
> +
> +	mutex_lock(&em_pd_mutex);
> +
> +	if (list_empty(&em_pd_dev_list)) {
> +		mutex_unlock(&em_pd_mutex);
> +		return;
> +	}
> +
> +	list_for_each_entry_safe(em_dev, tmp, &em_pd_dev_list, 
> em_dev_list) {
> +		if (em_dev->dev == dev) {
> +			kref_put(&em_dev->kref, _em_release);
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&em_pd_mutex);
> +}
> +EXPORT_SYMBOL_GPL(em_dev_unregister_perf_domain);

Ok, so em_dev_unregister_perf_domain() does not support the CPU 
device
and a subsequent em_register_perf_domain() will fail with EEXIST.

Is there a way to unregister/change the CPU's energy model during
runtime without restarting the whole system?
