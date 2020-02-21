Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D40167E1C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 14:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgBUNMd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 08:12:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36850 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgBUNMd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 08:12:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so1798202wma.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 05:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=a/KavHLvvULXfL2VP34j+gxXqKWZ5d3n9oQaqLdPQv4=;
        b=eib3Jfwyj+tZtw0Vz5eRWnOQiMb9kRoD6q2gN2p55T9aS3rgoCUuv4jkOzgSy6JAgQ
         LEjM/7bJFu5XAMFaMvFkgF8XI6h8ICSPxck1TJrj6R8L0TLPzxasmiTqaRBEuJSE492o
         xUPyAD7jB/fuLzt6Z6u8a/djHUo7qip9vuLowvh5OaxbICooz75RPYWXY584WFX80Hsq
         UecpvDo6HfzMYfFJjPppbxEhywhbLPSsEWUgzWENhmVwerLyCsfebJ75YhAi0BV6oT34
         gcEUPT4zy5xBisJiKhATgcWrOM/bv0x40XtU3oXOP8d4vAUNTTge4+2/pCIL965PidD5
         SzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=a/KavHLvvULXfL2VP34j+gxXqKWZ5d3n9oQaqLdPQv4=;
        b=KnEJ3leq1RdCkOdxmOAo7/uui4tQpVmevxXeJjk68DYFbiiuQ4WgieG8KRYS7DwpM2
         nAgUMDG9PSaVu5rKzI7HuKXMeMoyIC5Tv01S+9VCFIDWcS9bZjUT+phwKIpfcaEpZnoJ
         fzS0pHHNG3BZeMSYUJz5Zltet0KxXORObEursvcPHKgUm9l/ZqrUYIuwSdxEeK+NUKxs
         TkYGzsMC+vJFWSl2ffQuUPwNUIt9m7CS/do+NI6SzIZbgdGbbbaA/cBQ9hCJ1cknJ3YF
         CToI9vCIxLlB5U/QV0KrkoBZQYaeYxrn1XnQd0Ge8HE72kSHK38zTzeQT0jNmuT/CnRd
         KQMQ==
X-Gm-Message-State: APjAAAU3b3A7dOt7dIcGAB2IoBBSVG7WeINwl9Lj+d7Q5jkoCTb9rTZk
        BBKze+JcG6FkxnJWT+7O3EVflQ==
X-Google-Smtp-Source: APXvYqx5emu1fdVAd6Tj3p81RSkBc6Mf5Yyr0nrkLGXMlG0khLLYOloIT2vAb1bEk0+GwUGFpzZSvQ==
X-Received: by 2002:a1c:4e02:: with SMTP id g2mr3929356wmh.131.1582290750388;
        Fri, 21 Feb 2020 05:12:30 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:2dfb:b5ce:9043:4adb])
        by smtp.gmail.com with ESMTPSA id c15sm3881537wrt.1.2020.02.21.05.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 05:12:29 -0800 (PST)
Date:   Fri, 21 Feb 2020 14:12:26 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Andy Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V15 RESEND 2/5] thermal: of-thermal: add API for getting
 sensor ID from DT
Message-ID: <20200221131226.GE10516@linaro.org>
References: <1582161028-2844-1-git-send-email-Anson.Huang@nxp.com>
 <1582161028-2844-2-git-send-email-Anson.Huang@nxp.com>
 <20200221091112.GA10516@linaro.org>
 <DB3PR0402MB39161BB726FE5413F30F0263F5120@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB3PR0402MB39161BB726FE5413F30F0263F5120@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 21, 2020 at 09:26:29AM +0000, Anson Huang wrote:
> Hi, Daniel
> 
> > >   *       a valid .of_node, for the sensor node.
> > > @@ -499,36 +546,22 @@ thermal_zone_of_sensor_register(struct device
> > *dev, int sensor_id, void *data,
> > >  	sensor_np = of_node_get(dev->of_node);
> > >
> > >  	for_each_available_child_of_node(np, child) {
> > > -		struct of_phandle_args sensor_specs;
> > >  		int ret, id;
> > >
> > >  		/* For now, thermal framework supports only 1 sensor per
> > zone */
> > > -		ret = of_parse_phandle_with_args(child, "thermal-sensors",
> > > -						 "#thermal-sensor-cells",
> > > -						 0, &sensor_specs);
> > > +		ret = thermal_zone_of_get_sensor_id(child, sensor_np, &id);
> > >  		if (ret)
> > >  			continue;
> > >
> > > -		if (sensor_specs.args_count >= 1) {
> > > -			id = sensor_specs.args[0];
> > > -			WARN(sensor_specs.args_count > 1,
> > > -			     "%pOFn: too many cells in sensor specifier %d\n",
> > > -			     sensor_specs.np, sensor_specs.args_count);
> > > -		} else {
> > > -			id = 0;
> > > -		}
> > 
> > Please take also the opportunity to factor out the function
> > thermal_zone_of_sensor_register().
> 
> Sorry, I do NOT quite understand terms "factor out the function ...", could you please advise more detail?

Never mind, I realized I puzzled myself with the changes in the series :)

Thanks

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
