Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC30B197FD7
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 17:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgC3PjR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 11:39:17 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33215 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgC3PjR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 11:39:17 -0400
Received: by mail-io1-f66.google.com with SMTP id o127so18236276iof.0;
        Mon, 30 Mar 2020 08:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EZ1nff7YVijHzSQUa7ruR5O25OH0APmgrgDxrtZq5h4=;
        b=haURtfDgYWITnFVn96lwrRuVtQnC5N/kbofVhztHQCFCGrAwuHFYXJnZ6JkdPML/lp
         HSeSLtnKRkV5O/mWayOXOKUIFtF1LoqX8kbULjX2Zm0VfVYGjwRgeq4NhSk5dq/yDgqy
         CUZ15w5ejBWEEIkqYWTi+sflqH58RGYIAl3iFKkfSdSwKK+KihL3Ts+5KeMS1M+w4TbZ
         XJW9NrUQh3SrbJ8I4P5sLfphTcJI5ufVkSGXkwGURG8dFuYsFP78bKPxJc48U9+VDnIZ
         3dK8DrHqRPAvNNgwk0WhTgQa3nFuwkNaaqrdd1GihWkWQDYe1Hyz1a4e6EXuE6aks+Tz
         seeg==
X-Gm-Message-State: ANhLgQ25l+XwpCgSNqxYMZxO3C3pu69htFr+B0jH7miJJ4Z7VJ90Ntjf
        TvFRC7gkBg5P9XUwzJO/5g==
X-Google-Smtp-Source: ADFU+vtAbJIIRWynygDv7+bYMc+vjWB5ZJKEe6w3jC9R106pug4ci8qV3wN4dQNxIjcAu3fiI/HPww==
X-Received: by 2002:a5d:9a06:: with SMTP id s6mr8991926iol.165.1585582756185;
        Mon, 30 Mar 2020 08:39:16 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u77sm5012485ili.35.2020.03.30.08.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 08:39:15 -0700 (PDT)
Received: (nullmailer pid 20530 invoked by uid 1000);
        Mon, 30 Mar 2020 15:39:12 -0000
Date:   Mon, 30 Mar 2020 09:39:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Martin Kepplinger <martink@posteo.de>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/8] dt-bindings: interconnect: Add bindings for imx8m noc
Message-ID: <20200330153912.GA20064@bogus>
References: <cover.1585188174.git.leonard.crestez@nxp.com>
 <b7a93b75a3ea57aadeeda766a0b729a4bc97ccc9.1585188174.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7a93b75a3ea57aadeeda766a0b729a4bc97ccc9.1585188174.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 26 Mar 2020 04:16:13 +0200, Leonard Crestez wrote:
> Add initial dt bindings for the interconnects inside i.MX chips.
> Multiple external IPs are involved but SOC integration means the
> software controllable interfaces are very similar.
> 
> Main NOC node acts as interconnect provider if #interconnect-cells is
> present. Currently there is a single imx interconnect provider for the
> whole SOC.
> 
> Other pieces of scalable interconnects can be present, each with their
> own OPP table.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  .../bindings/interconnect/fsl,imx8m-noc.yaml  | 138 ++++++++++++++++++
>  1 file changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml:  while parsing a block mapping
  in "<unicode string>", line 4, column 1
did not find expected key
  in "<unicode string>", line 79, column 9
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1261720

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
