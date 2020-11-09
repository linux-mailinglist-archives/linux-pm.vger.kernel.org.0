Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515642AB179
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 07:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgKIG5p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 01:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgKIG5p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 01:57:45 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1E7C0613D4
        for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2020 22:57:45 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id f21so4264939plr.5
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2020 22:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KF1/cMn6ow1Nl4dL4x6qzs3WxXHhYa+fonGftd0XHGk=;
        b=zXLhGIo6SEIUKcewyE6ufIb64yJVWCABNtTkBYh7d4D4TvYXa540vr/vFWmzrxVxyb
         wlC0XFXCqonycWbXTsMVO+x3Py2FcLnChddb3OLJ3dHSS1jUaozYWj2h74tMNky805Uw
         lOObM4byt6gHew/oAXo1GSDjAxHmOjPTe/D30uCZl/Rji4N4RWJH1n0EHvS0LMlTTY5e
         h6iD19z5V/2lsqIBMxCuPE3/J0o1IoJNinBcoUQtFEtYKl05r24H3x0kFQ1yWbb1jdi0
         XyOkkwP7iOzCyo84BvoARxMew7Flcf1qG2gciFljzZc+UgbEDc3bSwkFZxCi307NPWcH
         +zpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KF1/cMn6ow1Nl4dL4x6qzs3WxXHhYa+fonGftd0XHGk=;
        b=eED5IsAcxZbHqdabVa1MDRO0S+4MDWOkitVAdsnGI6lVbDrTV7lDkjSp9hdNw94Muv
         u9NOFbgbi3WSGOA//Pm3j58hlNaNZZj0AC6BzCcXXMv0VwSbQEXdGxLLA3YZOHGmLHrz
         GHoGum5EXEnIE2ustJz/wX/0Q1uMHwIuCLEHyCHOLAg/JUcvyuis6jPjndLEo4J6BHVD
         sl7sanQm6/0fhd0r5xb8ILdfBjVrKTMK7OQQ1EMUVMFUe/1CfkOI+D/d5ibn5BCw6EQE
         8x3pGp2QzIMP4/6PDWOtwRgVF8BSQ1gdH6FRK5Bu7BfbfYIbGJ/FLJWgduI6+stEIE5s
         6w1Q==
X-Gm-Message-State: AOAM5300q8VX+uWgjE0qiujkvwjnbJc/HYW7dG3W1+IfHi2WAZAESxfK
        HjQ0S+jkOvafJGUimP8msLFlNw==
X-Google-Smtp-Source: ABdhPJw+XEDLwRGrEJmvpdHPokEDmxTA6uwQTvouoJ2/owTVyISLQ9AuM70t0bW5X57j8Gwmgr9IJA==
X-Received: by 2002:a17:902:6bc8:b029:d6:d9d:f28c with SMTP id m8-20020a1709026bc8b02900d60d9df28cmr11217116plt.17.1604905065103;
        Sun, 08 Nov 2020 22:57:45 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id d9sm3157998pfn.191.2020.11.08.22.57.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 22:57:43 -0800 (PST)
Date:   Mon, 9 Nov 2020 12:27:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com
Subject: Re: [PATCH v3 3/3] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201109065742.22czfgyjhsjmkytf@vireshk-i7>
References: <20201102120115.29993-1-nicola.mazzucato@arm.com>
 <20201102120115.29993-4-nicola.mazzucato@arm.com>
 <20201106092020.za3oxg7gutzc3y2b@vireshk-i7>
 <0a334a73-45ef-58ff-7dfd-9df6f4ff290a@arm.com>
 <20201106105514.bhtdklyhn7goml64@vireshk-i7>
 <7f73bcd6-0f06-4ef0-7f02-0751e6c4d94b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f73bcd6-0f06-4ef0-7f02-0751e6c4d94b@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-11-20, 11:14, Lukasz Luba wrote:
> I also had similar doubts, because if we make frequency requests
> independently for each CPU, why not having N cooling devs, which
> will set independently QoS max freq for them...
> 
> What convinced me:
> EAS and FIE would know the 'real' frequency of the cluster, IPA
> can use it also and have only one cooling device per cluster.
> 
> We would like to keep this old style 'one cooling device per cpuset'.
> I don't have strong opinion and if it would appear that there are
> some errors in freq estimation for cluster, then maybe it does make
> more sense to have cdev per CPU...

Let me rephrase my question. What is it that doesn't work _correctly_
with cdev per cpufreq policy in your case? What doesn't work well if
the thermal stuff keeps looking at only the related_cpus thing and not
the cpu-perf-dependencies thing?

-- 
viresh
