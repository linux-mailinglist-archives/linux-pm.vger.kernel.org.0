Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1754EDC8DA
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 17:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404794AbfJRPfR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 11:35:17 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33302 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfJRPfR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 11:35:17 -0400
Received: by mail-lf1-f66.google.com with SMTP id y127so5079267lfc.0;
        Fri, 18 Oct 2019 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4cEbWVoMsomp5+smVoDWnMUG+heNzW3PrwY50bFdoEc=;
        b=etA65N0L5/S+fwIc3YZUUZh84+iGUKox/ueSm4qpWgZghQgqxD2HWoEXNNo4l8SvYc
         L20bdDMxfJGd16qkuo/sZ4j1p3BVyB7gmivjabYtrzres3YcK1BAGZb5/XDhQDlgGYtH
         fzrtRjP9Crb4RoWE9/Dx+acs5lIEzd3l0YSc2doBxidXSX2td2X3yKFfB+FsUTgrkFA9
         1DFC9KmRFVx1La6z/tjDJKtPqwcm4C+N3YMcbycA4HRN3dUBFo+uIBgQU6sRvEJj/F82
         M/mx82ggV1uMhSgC0z+cCp9K61rL3Bf+kLvwhGAHmfsd7/Qhs4FG5N3p9jtG3FRxt+Nc
         gWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4cEbWVoMsomp5+smVoDWnMUG+heNzW3PrwY50bFdoEc=;
        b=OiUYsDDUnbhwOkrLAouXpqovFSQ0uOPwFSAkSJ2wGiDXNmb2MF6/NMRrvetFkq0zQ3
         o4mNsT7cnCR4eCrvXtH4ag72mJouWl1FOBJZBR1NkOC4FCpS7ZagxTHySQfhaAyw7oSM
         IBKReUbc5Vy4NFIYIFjAFEtvdibDM0Qjj+0xvILhO4Xu7q/exxUHrzOlP3r4UIYTo3l4
         282nNn/KL+OfIhaiDUi0K/12uK6HLnW7CI0tkS0FAL7t3lWqr0ZV1j26WJm+PaYXmEgO
         ZTF9UkUk+Kxh9LvdVpcsTJ5oEmgh2EDpeDRGG2TeESAldipldM+G5Li2PL2VtvQ50a43
         Byaw==
X-Gm-Message-State: APjAAAVGkhamR4d3tyIf1cS7y/b6MtqbH2efqKjVY5V47pWttKC/TjN4
        CJC5jY1ZQ6v6rC6tOYlmf3l8dks1
X-Google-Smtp-Source: APXvYqw80j5ipJulm8UbDjl4XTHI89oYL6Y1/kniXE+dnHyX8NQnFl7UazpiBcQR1JPbf1Mn2T1uxA==
X-Received: by 2002:a19:651b:: with SMTP id z27mr5121254lfb.117.1571412915156;
        Fri, 18 Oct 2019 08:35:15 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id p18sm3208038lfh.24.2019.10.18.08.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 08:35:14 -0700 (PDT)
Subject: Re: [PATCH] opp: Reinitialize the list_kref before adding the static
 OPPs again
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
References: <2700308706c0d46ca06eeb973079a1f18bf553dd.1571390916.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b1d263bb-f797-0f0d-5beb-0747c564ca90@gmail.com>
Date:   Fri, 18 Oct 2019 18:35:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2700308706c0d46ca06eeb973079a1f18bf553dd.1571390916.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.10.2019 12:28, Viresh Kumar пишет:
> The list_kref reaches a count of 0 when all the static OPPs are removed,
> for example when dev_pm_opp_of_cpumask_remove_table() is called, though
> the actual OPP table may not get freed as it may still be referenced by
> other parts of the kernel, like from a call to
> dev_pm_opp_set_supported_hw(). And if we call
> dev_pm_opp_of_cpumask_add_table() again at this point, we must
> reinitialize the list_kref otherwise the kernel will hit a WARN() in
> kref infrastructure for incrementing a kref with value 0.
> 
> Fixes: 11e1a1648298 ("opp: Don't decrement uninitialized list_kref")
> Reported-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/of.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 6dc41faf74b5..1cbb58240b80 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -663,6 +663,13 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
>  		return 0;
>  	}
>  
> +	/*
> +	 * Re-initialize list_kref every time we add static OPPs to the OPP
> +	 * table as the reference count may be 0 after the last tie static OPPs
> +	 * were removed.
> +	 */
> +	kref_init(&opp_table->list_kref);
> +
>  	/* We have opp-table node now, iterate over it and add OPPs */
>  	for_each_available_child_of_node(opp_table->np, np) {
>  		opp = _opp_add_static_v2(opp_table, dev, np);
> 

I don't see the warning anymore, cpufreq-dt module reloading works fine
now. Thank you very much!

Tested-by: Dmitry Osipenko <digetx@gmail.com>
