Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1CE43C148
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 04:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390846AbfFKCiP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 22:38:15 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:39678 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390473AbfFKCiO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jun 2019 22:38:14 -0400
Received: by mail-pf1-f169.google.com with SMTP id j2so6413667pfe.6
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2019 19:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VzbaCUeairlB7SV9tBrRxtSBGLQPN2IpzYdKT1AqRHM=;
        b=Q+zRpjrbyJm8yQeUStTnWUtyUIayjzHZDfZDp+elDSTN3E4gjC4q2wmSZ1WkjIld4W
         xK+PBrb/7FWR332jiYaXMpvb5Gz2hpv5ughyBnNjyfGdv5bS83rgfcT6IfO637qUErGS
         650EKYXNwyXkKY7P1eT2uzDzuJ+gs/LHXO5d9DCh8XwuERiN+U5LqzhMsanfWppKdBZV
         zADZo025r3gIfNQ3xwKImvE3IlwyJPcLdkaeZ18BfQo1+pARbRdP+SzZTSD0jdtjPfOe
         Ia5WPOB+qHZj00b2BhQL71ybq0qVudOa+/NpKD3iLR2wzlrUaDGu11YybnLwj4ZuIi8h
         8npQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VzbaCUeairlB7SV9tBrRxtSBGLQPN2IpzYdKT1AqRHM=;
        b=P1jj/zj+f13/2+NburabWOXY0gD6icUOlVGqTaPQPcrtOcfDxc+Cs12F0+2HlBbQUb
         6QU1aRcSxyhpYPYyjE+z4mzhiATFwL+C/QHlmOPIUyRD1ePoHEGZnMthX6j2f76vVR/N
         EPTmYC3L3gWk7kSY60Qd/d/FYw+9FSR4D468AKyCHfZhOaqIHinz15pYpuX7/qF/M8Yy
         3Lmu2xq/3Oqc+otMoUyNlJsYd7yT4YdMTFCkgSEeTP/aIPtLyOq2RHDAburDOxxIiyxE
         mdkJmDYA29CjYrPy1by2Y4c12ZtE/x7mzFEPakUzAm5Yft6ypvL5Gf2XNuBXuaS313Q6
         usPQ==
X-Gm-Message-State: APjAAAVEFsLmWXwzAqiZeCR+xPyGxGvCepw7zkx8N1YIp2j+BDxVkI4E
        esid2gDJ4CBXXaHAKedQcwSyhA==
X-Google-Smtp-Source: APXvYqy0mB8jLiynhhQ3AwP14lHYE4hjQyOQPc+u/uwTzhBrDCfJUKQTM0HOWMCjFEH3KqdJeyJMdQ==
X-Received: by 2002:a63:6841:: with SMTP id d62mr18009567pgc.17.1560220693808;
        Mon, 10 Jun 2019 19:38:13 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id j13sm10899658pfh.13.2019.06.10.19.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 19:38:12 -0700 (PDT)
Date:   Tue, 11 Jun 2019 08:08:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC] devfreq: Add generic devfreq-dt driver
Message-ID: <20190611023810.7lrgnyqqkuajlm6p@vireshk-i7>
References: <e48d7e3d71166cea20c3c200300e0ffa6d26d085.1559737589.git.leonard.crestez@nxp.com>
 <20190606031526.xknv5qdoqufim6tr@vireshk-i7>
 <VI1PR04MB50558EF0387824D6AAEEB18EEE130@VI1PR04MB5055.eurprd04.prod.outlook.com>
 <20190610234844.CC289206C3@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610234844.CC289206C3@mail.kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-06-19, 16:48, Stephen Boyd wrote:
> This still looks very much "virtual" because the NoC node doesn't have a
> 'reg' property. Is there anything the driver will do besides change the
> frequency of the clk based on the OPP table? If not, then it still looks
> like this is a node for the sake of making devfreq happy to probe via
> DT.

Exactly.

-- 
viresh
