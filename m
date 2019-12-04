Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD99112E30
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 16:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfLDPWY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 10:22:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38133 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfLDPWY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 10:22:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id k8so8566196ljh.5;
        Wed, 04 Dec 2019 07:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WXE7XkNkgq5Ryc0BGF4vj9reI7uFX8qbQNcWUJ9ADaM=;
        b=Dt448IQC2i0MNywuhrWBQNwAfVB6y4dypqdsH8rJGV+Q0SX59JzVMydSBS5SHecLFp
         Ye248dKB6j2KXx8qgkQm3TwsZvIpmuQxYly/o+n3mCZlWwQGs68yz1X97ZWuP1++3TeM
         XWv+ozQzT3uGiyi96IAI4XVc/oZ/b28zpIqBuillI2UI8o8wv2fdszK8sW82Miau8GDW
         9wXeKdYste/uAwf9QIztwYcQb3AnEgWzMjkUpFX9f8rTKPdJC5nKn9gamMvK4YQP6cki
         le6rArl7NhyJT0nU5GfyNXwraQaH0vrrBIpYnR+OOgMyZeiiUrA3SsqQS9JA84bvg9B5
         1YQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WXE7XkNkgq5Ryc0BGF4vj9reI7uFX8qbQNcWUJ9ADaM=;
        b=IZQqB+zZ51O5nIXN6wGRfBuVRqAtrKOobXM2yrM+46I0smMBst+SmaodWZLfe8wY/h
         yx0d89e8TXSC7YW3aZZNMnR2oec/5f4n3LURyRKxlBAoJ3iW0rGmzKttxkKOMH2SivYB
         E90kPpMLQ+CDt5BGoHEhgiR0hiKte7AQ0FTWqFgrjD8qfhaLDnMUsCPd6hR8Sc6yUG1/
         FW0ouon0kCMn1UczQ+cBppYIPTgtrzorrTo2pPtqPEwvDrq/mcAR0wrVaCi6BN+8zIsA
         Yd7fkrmADaxSZUtoE5a5odWkGBjE1Abjd9zgRp1wqcKzbmRA1brOutyUf8APvBwyiD/Z
         +NGg==
X-Gm-Message-State: APjAAAUMUDuizf0H1kRkbQJSV1b0YFHPOSn4p8jiX0gIDXolnF6lLI+7
        vktwR82TLrxBGPXv1dMDSFSXhD5d
X-Google-Smtp-Source: APXvYqz3fKbBicJVvkmjihgLoVHT6+C2GHcFXQ6wv1iu18C+Hc2xtjyoHdsZN0PNeriXbCu/IO5Fng==
X-Received: by 2002:a2e:90c6:: with SMTP id o6mr2363361ljg.93.1575472941563;
        Wed, 04 Dec 2019 07:22:21 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id a24sm3289856ljp.97.2019.12.04.07.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 07:22:20 -0800 (PST)
Subject: Re: [PATCH 2/2] drm/tegra: Do not implement runtime PM
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
References: <20191203162733.1436800-1-thierry.reding@gmail.com>
 <20191203162733.1436800-2-thierry.reding@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3d2b4fed-d2e6-bb4a-c94b-d493ba836661@gmail.com>
Date:   Wed, 4 Dec 2019 18:22:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203162733.1436800-2-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

03.12.2019 19:27, Thierry Reding пишет:
> From: Thierry Reding <treding@nvidia.com>
> 
> The Tegra DRM driver heavily relies on the implementations for runtime
> suspend/resume to be called at specific times. Unfortunately, there are
> some cases where that doesn't work. One example is if the user disables
> runtime PM for a given subdevice. Another example is that the PM core
> acquires a reference to runtime PM during system sleep, effectively
> preventing devices from going into low power modes. This is intentional
> to avoid nasty race conditions, but it also causes system sleep to not
> function properly on all Tegra systems.
> 
> Fix this by not implementing runtime PM at all. Instead, a minimal,
> reference-counted suspend/resume infrastructure is added to the host1x
> bus. This has the benefit that it can be used regardless of the system
> power state (or any transitions we might be in), or whether or not the
> user allows runtime PM.
> 
> Atomic modesetting guarantees that these functions will end up being
> called at the right point in time, so the pitfalls for the more generic
> runtime PM do not apply here.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---

Couldn't we just use pm_runtime_force_suspend/resume whenever it is
necessary to enforce the suspend/resume?

I briefly looked through the previous discussion and don't see why the
forced suspend/resume isn't suitable. Please excuse me if I'm missing
the point.

Why planes/outputs need to care about resuming DC controller at all?
Doesn't DRM core take care of enabling DC for us by enabling CRTC before
planes/outputs are enabled?
