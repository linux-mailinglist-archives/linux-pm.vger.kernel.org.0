Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFF7C10B8F
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 18:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfEAQsq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 12:48:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34192 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfEAQsq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 12:48:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id ck18so4129847plb.1;
        Wed, 01 May 2019 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a82ckZo73SGxA8ey3aK0omtfrwDTACIRQAmbz4zxBz8=;
        b=DZAZlVyv2Zj8QW2ZVaA4F2WxBgm+TYZTAM4t/5EOeChgCJ7BD4Ft2Dzmnf3x6+ydz1
         XakRftqblAOckP3MeN3ccDznp09ppAFe871YQDxI1Qj+FuNPuoY1ouHhz5kI+3ZQ3PV3
         /L68VP9/OZfwUxqTI2ADGPFduqoKJR0cQ/ilRG4LirfK9AWJ1nlO4sVAtoc4jAZjVELX
         dwxVevKkDwYvFLwv52/XqZAeyBzWSZ5CO4uvi+nyaZGWjFQjY/27kRLDK4iQOVPv1bS3
         pYU7oLCM3TjBP/5voYoXBOCWgkWx+/gNSfwEsWL5ioDvofaSRT3AzcJ5BrlWCeZEJ+vp
         9TMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=a82ckZo73SGxA8ey3aK0omtfrwDTACIRQAmbz4zxBz8=;
        b=eRcacc6vuWJ2IS6LXieJP2nV+JdPyK0DzVyTLlpNteUKuYtVLTDB0NNWxFxVMRyLjb
         jkZpXMqpSxzbj/mmdgDewI9SRm1gkEWnpkRbVCAuVNixmsOJD70pwuK0LPi2FHOaaSmm
         hFibVoZeRDX1/wyManUZduKYreqenLrLAx/hOuOoKAwJdqC+MnjYFlK3Xikj96r/q1p/
         toFtIaV03CFd2ihqtn34U663ftD5jqWyHE2G3acj5LIQJTYHsElQFPf5CMjs9aVke1Zo
         d/piFGUMZ2ufbdSBy3Nt++szGHwQwzqUvoPiyhi/KOEjj1piT95aSD9cmKqJyTOYfdjG
         EEow==
X-Gm-Message-State: APjAAAVOZsxdWBX/W9WK/VXby8JYo+/mV9bMdXGB6vtluQfByrpjuZj9
        HWcbFDc5i4j7omHFxG3mH5nBogrN
X-Google-Smtp-Source: APXvYqxW8qIcb4HhSImxk+i+ozqc55UYdRTl9MHwDSKvhigyPhTtplKP1yE1tqeQ0DpYt8I1Y+S+aA==
X-Received: by 2002:a17:902:163:: with SMTP id 90mr79079707plb.34.1556729325186;
        Wed, 01 May 2019 09:48:45 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r76sm62426017pfa.39.2019.05.01.09.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 09:48:44 -0700 (PDT)
Date:   Wed, 1 May 2019 09:48:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/6] thermal: Introduce
 devm_thermal_of_cooling_device_register
Message-ID: <20190501164843.GA16333@roeck-us.net>
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
 <1555617500-10862-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555617500-10862-2-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 18, 2019 at 12:58:15PM -0700, Guenter Roeck wrote:
> thermal_of_cooling_device_register() and thermal_cooling_device_register()
> are typically called from driver probe functions, and
> thermal_cooling_device_unregister() is called from remove functions. This
> makes both a perfect candidate for device managed functions.
> 
> Introduce devm_thermal_of_cooling_device_register(). This function can
> also be used to replace thermal_cooling_device_register() by passing a NULL
> pointer as device node. The new function requires both struct device *
> and struct device_node * as parameters since the struct device_node *
> parameter is not always identical to dev->of_node.
> 
> Don't introduce a device managed remove function since it is not needed
> at this point.
> 

Any feedback / thoughts / comments ?

Thanks,
Guenter
