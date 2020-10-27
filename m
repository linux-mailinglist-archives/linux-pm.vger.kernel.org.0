Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0090529CA32
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 21:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437142AbgJ0Uag (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 16:30:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34400 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436921AbgJ0Uag (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 16:30:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id y16so3315158ljk.1;
        Tue, 27 Oct 2020 13:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xIMfAXFiMN14kIOtEDp4rVS1/lZfGWxB0FToCxiOcv0=;
        b=fLeCZRoi/NbdluOH9GChFb9hVKMiWXbyUnQsUyk4GeXxzi5Gz+jkyx1ECk6IFfsOHJ
         Z4hQ7h1ZCFVpZvWUoZyJIlMHwpbUhkydyYIyAlw3pHU57KvDJl4ziqS7CepyQTpUcj3k
         x2Yb0Gm6P3GQR4jt2PqI3/IojM63m8I7EOV6+/TML7imF4UJHfrI3kWAVF6LQtfW+KFw
         8dUTsRjnZMTD/Rrr0e1CW4Fbl1aVOiJoFnjj+LV4ELb5qi7QYLvINWmJ6XwLT68CZUt5
         W7e0OHQxvw4T94TBYncahUslEv6sdK2+WBuJ/6ao9GB3tkYLWqBRJVA3sC5BCmm5I2gH
         8/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xIMfAXFiMN14kIOtEDp4rVS1/lZfGWxB0FToCxiOcv0=;
        b=srxVcD4FuhuLWCzvm4kj7miw6VFHaY+Ax9SMMqaoRWiZDtpt+PlBH7GVtcePqdFK3f
         8AS2EtbPsKUFaUBRwBLaLmh2JQfnM+RivVU/obCncW3BZMGxApObbXtZG0L2iWWJ5ach
         TwhBzgHjpnv9u6VkapfGf5XWzErswmNfv+J5Q92TXInE+imZsrVUd0UxZSTIEerFC7RR
         ucMO/vqbZOK5CEkTwV+rYqnF73t29hPKFZsAg2mM3J1Um6TAbTfknqTjVbRC5DlZLa63
         R75Ti/sbJVQ3wDkDe95/Em/k0gNic0gW3p6iUU0ekqs2VQlC8ZftGWzOb/4U9DsExFeH
         +ELA==
X-Gm-Message-State: AOAM5318d4eGvwxxlaI1oL10DVk6YOmvNuPsIU2Un4QanADKRYn4O4Mm
        NiQq+Pfldig5MOde/CesgdmuBq9NyNM=
X-Google-Smtp-Source: ABdhPJxKa4m/gbvwQbmxgMvINe+bK5H6koZp7YuoStfXjrjjYtRl7Hc+aAnh0WptiQo+vFNmFcvw/Q==
X-Received: by 2002:a2e:b04a:: with SMTP id d10mr1947668ljl.81.1603830633050;
        Tue, 27 Oct 2020 13:30:33 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id e140sm284016lfd.218.2020.10.27.13.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 13:30:32 -0700 (PDT)
Subject: Re: [PATCH v6 41/52] memory: tegra124-emc: Use
 devm_platform_ioremap_resource()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-42-digetx@gmail.com> <20201027102707.GC17089@kozik-lap>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d79e4972-acf9-f889-50b8-f0829a0e8e08@gmail.com>
Date:   Tue, 27 Oct 2020 23:30:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027102707.GC17089@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 13:27, Krzysztof Kozlowski пишет:
> On Mon, Oct 26, 2020 at 01:17:24AM +0300, Dmitry Osipenko wrote:
>> Use devm_platform_ioremap_resource() helper which makes code a bit
>> cleaner.
> 
> Such cleanups (and few other in this patchset) should be at beginning of
> patchset or even as part of a separate one.  I think there is not much
> stopping anyone from applying these... except that you put them in the
> middle of big dependency.

Some of these cleanup patches can't be applied separately without a need
to make a rebase. I think it should be more preferred to have all the
patches within a single series.

I'll try to reorder the patches in v7 if this will ease the review, thanks.
