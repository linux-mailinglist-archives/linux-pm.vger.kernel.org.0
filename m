Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8640DBD25
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 07:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442020AbfJRFla (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 01:41:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33354 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391953AbfJRFl3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 01:41:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id i76so2727999pgc.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 22:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p0ZcA5/U4vLBP3fm6ZAT4nlCcb5dQ4JwVYP/+NI5L6w=;
        b=Rq4Rw84jFpBv+yeL1kstTX8oUutO2S4aOm/OKwIv0HgnEm+eEWyDVp+n+8sV/yLTlp
         EKNLZNFpF/6t0n6akdQb6609x3y19LkwO48lMQrq+mLQ1bv3DpCLuS5ohwyegSa08yKf
         CqkF4CgAc0jtuOKIUMudTnVuk8MMCG3MVyIYs/YU61Hbb3zRxI9JgxFWiUWZQVwz1yXa
         eHuGTbH/apzwV1r0LiLS5r9Rz8N51bC1LcbgWN7HuAoMf5BD+d2ktkJ6+tg7EeE22NTL
         e8MhubDpr7usb9CeDrkGO0y+6iqpx2UuYMg/Op6fwXmBI+IStEyRnouVbgCXf0NRZJlD
         rWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p0ZcA5/U4vLBP3fm6ZAT4nlCcb5dQ4JwVYP/+NI5L6w=;
        b=Bixos05sxW+jqJXhEn96k8MPYqa2bK0n8bp2WkFwxYC4gkLwVWXQQtI/PlqSDAEiRw
         l6bwNETnx7+379ss+YYcNLiZAqIn7d0XC5PrqODvAYJdpgb6Ow1lSAWs9cDvj2Tq0v5t
         0kWAT7wVMq+xBHUNIjcCHYaNWJ90tHFp+FcOVBlGzLAy7btAWRAwR4QjywmU0IEKB5np
         JVZb11OeH2pqywRjWdFA3+PlD+gOl1USpSmVlzpfrQx07uNp4zFiRnBiw6PtwTI9Hn8K
         yOiV0ZzVhywXS7y7SwTMnJlHMmdS1Wd2LRO9F9hflantR5MDeO8pDGhl8SbK7yNC0x0g
         mJAg==
X-Gm-Message-State: APjAAAVZNuqxF0FrjYbrG4wOY4kCqXfNQmrhEIOQPSo47pAATrK0uv2b
        UdDDhUpVje0+Q4q0zQM56VzqrQ==
X-Google-Smtp-Source: APXvYqxCBYnbkeb5IZKjGre+6VciDOyz3GYaUWRD7jLEy8anyNUwplve1VOtoA2UYkJzC8Y5d9VTag==
X-Received: by 2002:a17:90a:9406:: with SMTP id r6mr9337135pjo.0.1571377289149;
        Thu, 17 Oct 2019 22:41:29 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id k17sm5036033pgh.30.2019.10.17.22.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 22:41:28 -0700 (PDT)
Date:   Fri, 18 Oct 2019 11:11:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFT][PATCH 1/3] PM: QoS: Introduce frequency QoS
Message-ID: <20191018054126.n7zsqut7z3hzh7bc@vireshk-i7>
References: <2811202.iOFZ6YHztY@kreacher>
 <4551555.oysnf1Sd0E@kreacher>
 <20191017094143.fhmhgltv6ujccxlp@vireshk-i7>
 <CAJZ5v0hDhJrCWnPxbV54yWAB=DKCLz33Sq8J4kXtqH4+mJn2eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hDhJrCWnPxbV54yWAB=DKCLz33Sq8J4kXtqH4+mJn2eQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-10-19, 16:16, Rafael J. Wysocki wrote:
> [Also note that the current code in device PM QoS uses MIN and MAX
> here in the same way. :-)]

Stupid me, enough embarrassment for the day :(

-- 
viresh
