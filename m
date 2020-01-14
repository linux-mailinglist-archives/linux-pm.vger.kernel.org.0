Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 952CE13B3BA
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 21:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgANUgY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 15:36:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41631 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgANUgY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 15:36:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so15910621ljc.8;
        Tue, 14 Jan 2020 12:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a7uP1zpb1ztpEYbYJJBds6WIHHRIrU9oQfAy4KVLdh8=;
        b=WkM6BbNgq866gAfEyXf/gMGTEPI7AGNlC+zQWZSwrcsNPuuPppyqnkFEBBtson9/Iu
         xGeijtj56fxzc76sFKTlKyjgyMGtdL9NA66kuAfzB6zAp91zZ3wMN5dnzriKZBhpr1cH
         TosQEr0TNEmseHF0LfUKTjmZIDx9M2PCEFYrKGQ8TqSCkEkqdNMitHggjtgCltAw6HcM
         oHIQowQ8VnukyVLrVlYfVUyO3I0yQ15B7EHiqQtVhV3oiBQCpuiJkmlYxDEhzFk5VmdB
         qfS4aYJwtURtwI6nkjHb3UwBHma2eyY1boZd03gbKorj3P9FqzRd1PtRsrj+zEwzc/az
         oqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a7uP1zpb1ztpEYbYJJBds6WIHHRIrU9oQfAy4KVLdh8=;
        b=JMVztwvnd+QNvnqYxr8DkDaFkbwDyckD6eNxXjWbg7cQHceL7DdCbkcY8MMu/EiHm1
         +oaGf/gIbo52b7QDW+bgj76shHX7oL2eEC6iwf9loaZjUuqSTmwf7/yxmFiPqh3j4u6A
         v+C3TTkbBJI4rdSwxOYXBgTAkdOZAFXze54y/5bjj8CPoQbEYzCrZjRLBiua6ahMMulH
         FKy5r+PYq9M7A2dBPqHAweSpWq031pU4VCDV5mbGbkAFFBoP8TafW04PmrT7UasU0EoP
         Eno188NPHcuzaXQrm89Zg0rViTPCnojV8KZ1YAYjuf5huHBm4YJMhiocr1BEJiIi9wiG
         ll8w==
X-Gm-Message-State: APjAAAUqlHGNsPMqKP/w0h2q9FGl64ZGxgoN/qY1yODAsaRplV6s66cF
        AH+MHjwZKPvFZo0guwx+/EqHwgCF
X-Google-Smtp-Source: APXvYqxe6Hlj5r5z0SlnmU6Lvr152puMRcx58+cpCLnqZW5j0mbPOf0IUgcQv0WPyX0GTg4xcIyEkQ==
X-Received: by 2002:a2e:3a12:: with SMTP id h18mr15983388lja.81.1579034181518;
        Tue, 14 Jan 2020 12:36:21 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id p26sm7784178lfh.64.2020.01.14.12.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 12:36:20 -0800 (PST)
Subject: Re: [PATCH v6 00/12] NVIDIA Tegra20 CPUFreq driver major update
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191218202142.11717-1-digetx@gmail.com>
 <20200114155306.GI28289@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3ebb7123-db2b-bacc-1f35-f6691a12c94d@gmail.com>
Date:   Tue, 14 Jan 2020 23:36:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200114155306.GI28289@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

14.01.2020 18:53, Peter De Schrijver пишет:
> Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>

Thanks! Should help to get these patches into 5.7 :)
