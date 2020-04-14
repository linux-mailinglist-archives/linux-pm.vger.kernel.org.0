Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241011A8F42
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 01:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634388AbgDNXqa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 19:46:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40149 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634364AbgDNXq0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 19:46:26 -0400
Received: by mail-oi1-f194.google.com with SMTP id t199so8645396oif.7;
        Tue, 14 Apr 2020 16:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8xSRt0kOxv48xywgi4ujHIQh1bkXuUAWN4jdwbwVrmg=;
        b=hnBwT31oe7gv7p9y5SoUsmhZWJfiWLghVW7jcjF1y1+9UEYxkzeygcDvVnrD/rUsWs
         0SLiY6W9YlZdWxSOcS2+wXS58wUeY56qbnOuZjzCNsDfLZxc1ZTJfD+edTq92+ehjvU7
         xaz5a5rEBnzSMIkCZhIA9GTZCoQALoZ9dc6HihF6c4UrLm2klxy5bt0Xc+v1B9vguDJN
         Q8AxvRAIZXxIZjQtDdGt6QZuMw4J4vb08cpQ4GH6vEjiZsxdsoOQlbeQpzcuTfQAsjTF
         Lg2LoHNSug7N+e+26aj3Xzry20DEURC9nTCYv4FOYp0FBlkGQ7lPihsAC5NV1exf1nPq
         D6xQ==
X-Gm-Message-State: AGi0PuZPJvWevUgff1sQn+o6HCjDGSiyuyL8w9AMU6XMj/gxKw62Rjy4
        58z4T7O3lLmaoIc/vw9/Ag==
X-Google-Smtp-Source: APiQypLjJgia8DtwmXlglhQCkIfrCQUjRk7EaaiM7wZQW5xPrKj1csIO6d+59LYkgp2CRhzOkOeC4w==
X-Received: by 2002:aca:3106:: with SMTP id x6mr5969478oix.94.1586907985808;
        Tue, 14 Apr 2020 16:46:25 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 76sm5895152otg.68.2020.04.14.16.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 16:46:25 -0700 (PDT)
Received: (nullmailer pid 22578 invoked by uid 1000);
        Tue, 14 Apr 2020 23:46:23 -0000
Date:   Tue, 14 Apr 2020 18:46:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
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
        Martin Kepplinger <martink@posteo.de>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/8] dt-bindings: interconnect: Add bindings for imx8m
 noc
Message-ID: <20200414234623.GA22499@bogus>
References: <cover.1586174566.git.leonard.crestez@nxp.com>
 <8b341d91e9aee679ae69feb22a2c842b2aeb2137.1586174566.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b341d91e9aee679ae69feb22a2c842b2aeb2137.1586174566.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon,  6 Apr 2020 15:03:06 +0300, Leonard Crestez wrote:
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
>  .../bindings/interconnect/fsl,imx8m-noc.yaml  | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
