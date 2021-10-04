Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B4F4207EF
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 11:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhJDJNX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 05:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbhJDJNV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 05:13:21 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A52C061787
        for <linux-pm@vger.kernel.org>; Mon,  4 Oct 2021 02:11:32 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id q23so13929951pfs.9
        for <linux-pm@vger.kernel.org>; Mon, 04 Oct 2021 02:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YnXBnzRi4479wrP+sOZpLMZLpiMj5aSP2rgmOi0KU+Y=;
        b=yHS0nO7iFlQxxeohVMKV6PWXnBayEsi9lK8tSdjyStFeIxmYN5rIMZxWjWE8H9QfQ7
         AvniVHR4oVvflXPr7rVbf8sVCWvLQiAfD2PqZZOaMZZagxylmkSlHyBj920ay6skehmA
         lwPjTUVi6b1oJKkZT0ky+bzsrvrsH1XTsPU+7POECpWl2AWydruKqWVrUMQtVvyTgJNZ
         9cA08qnu4tcOpHZUG2y+ws6DGVRR6nnOd2Q7S631komf0wGsVpsnKC0k2yEC97ewcBee
         Rlj7VnjufTy6C0syx9iS4lMwwcQ6JWoSgRGxLLVZ4yopWw1R7D8NUTmmgynLt2Yuhptl
         CQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YnXBnzRi4479wrP+sOZpLMZLpiMj5aSP2rgmOi0KU+Y=;
        b=XEOvc92nJDqaDbVgJA8gd5fl+juu75KeJ+3rBdPSCszShhhoh6mEzGz2L4TOG5LyN+
         v5Wxw9SQ4PKVGvodT9Gb9ZZPkw/gOsW67rEyPYuic/IvpHenuK6fMkUuBc/+LXb61aOQ
         WC7Z83LIsXx6H4uBB8maaEqxAU8/MjUd75zpw5hA/1mpFeCBcCXiWNQwNuWZWx+hevCZ
         qiL2bYEqu0j5tDb5niln4sJfxI3vuuG26HtTiKjnADXg9tw6LUOmx9ktmq5hFH2uF1HH
         X0kMNLAxlDMCxhjDfNrTO39wJKHev9WJ8CSK41/XIW12YFO1NRLcOb9cnyqzyyTjqcmO
         5aoA==
X-Gm-Message-State: AOAM530qr4rYXUoY8HO8vf4KkbTCadOzYfDrZcyTmzXUE2ISvBlERHrH
        Wshahdw7QNpOZsrgOg8JjOfNaw==
X-Google-Smtp-Source: ABdhPJxO8fMguXUXH6Qb+6kH1fEGOWCwG/KzlAh+unxySsrzptYsUWr9XN2Vqt7ITaHGghNVJjw0VA==
X-Received: by 2002:a05:6a00:16cb:b0:44b:bd38:e068 with SMTP id l11-20020a056a0016cb00b0044bbd38e068mr25041257pfc.34.1633338691658;
        Mon, 04 Oct 2021 02:11:31 -0700 (PDT)
Received: from localhost ([122.171.247.18])
        by smtp.gmail.com with ESMTPSA id p48sm13584576pfw.160.2021.10.04.02.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 02:11:30 -0700 (PDT)
Date:   Mon, 4 Oct 2021 14:41:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v13 00/35] NVIDIA Tegra power management patches for 5.16
Message-ID: <20211004091129.fhlfhsddzk5fakuj@vireshk-i7>
References: <20210926224058.1252-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926224058.1252-1-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-09-21, 01:40, Dmitry Osipenko wrote:
> This series adds runtime PM support to Tegra drivers and enables core
> voltage scaling for Tegra20/30 SoCs, resolving overheating troubles.
> 
> All patches in this series are interdependent and should go via Tegra tree.

So you don't need any OPP changes anymore ? I just came back from
vacation, don't know what you guys discussed in between :)

-- 
viresh
