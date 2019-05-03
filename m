Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E35C612B16
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 11:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfECJxv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 05:53:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38695 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfECJxu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2019 05:53:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id a59so2476799pla.5
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2019 02:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7ofI+h15j0GDGeZlGya+AQMCUiaNuXspnxN2fkw4ZPM=;
        b=XtPjLfB4MfBv111fFqlawZ6xTJC06jqxFZkxP39ROc0QJQq6zttHP6PioCI2yu7LAs
         uyn8BhF8NAMkl2O/YMWE9UTar43p7GWt+t8N9TXAm3h9H4EX25VTTOfReC/TsIsyksxC
         SIsIq85ROqWXPQ/qLli3NXG2AGcSAWIO7vmLvFEUkpFlS0/IlEqrX62DpJSGQenx0ApH
         c09V3at9K3FBPE3JE7jqNf0BPIJlh0eaoA8Sa/shqFfBSGs/QsgfzSlmNzOk8J9Rpn3J
         YavkUHS69gqJgDUM1ETZMyCGoz/bsdrYCIhmOycJwR9DUN+fqGP7G/c4MP00SgX3aj1S
         qxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7ofI+h15j0GDGeZlGya+AQMCUiaNuXspnxN2fkw4ZPM=;
        b=qX4RAh5bGvqsvR+mqEUlsTvzZFceTo2fuUDO452HxyAlRbsqYlnOF/pvoDBZcYNm3M
         IF0E4nUNVUxvpheAZdW6IHBDg8XIP5uAm4P4/uae17x84SqDr+iLzlppKa7oD8BljUjP
         vWC44Eu+SJ30HwGjBKEhsRpTuTuQ7xFWhI1R2uwY5jNVpsyB+z68eDoFtfHMf7OiZeEy
         PQ0YxyzFy/NENcZePoF4wLIuI0ouOBxfV72CXmXYiGeEvnAcTKMT/7UIUnmGFWbHi2W8
         60N39tnuAbF9zr6+2wtqR/kPOJzP1Z/u+Ge/iMGuK4tXNg/MIP+JrcUnOy+UqmNtv4wh
         iOCA==
X-Gm-Message-State: APjAAAVR7G7cP2iLTaLuq5wALw1iFTEw/+GDIzsO66JP19Y1qVRRwkfE
        ixN7LsIVe2IbdOQ2CZJqMWUr1vUsvTo=
X-Google-Smtp-Source: APXvYqwUPnOXZMe8Yq112fG/6x0/D//pZltFFv/1QHPPu10XD1agsD8njebFqKPeke/C7LLZJatj1g==
X-Received: by 2002:a17:902:b206:: with SMTP id t6mr9139257plr.130.1556877229775;
        Fri, 03 May 2019 02:53:49 -0700 (PDT)
Received: from localhost ([171.61.121.242])
        by smtp.gmail.com with ESMTPSA id b14sm2154078pfi.92.2019.05.03.02.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 02:53:47 -0700 (PDT)
Date:   Fri, 3 May 2019 15:23:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] cpufreq: Add imx-cpufreq-dt driver
Message-ID: <20190503095345.axz6pojgfmhgqjqa@vireshk-i7>
References: <cover.1556836868.git.leonard.crestez@nxp.com>
 <df3a41d8bf57b8dd8f8c17599eeca98d6e43962c.1556836868.git.leonard.crestez@nxp.com>
 <20190503065227.afqgmylbjwhg2mc3@vireshk-i7>
 <AM0PR04MB64345196835732B019F1D885EE350@AM0PR04MB6434.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB64345196835732B019F1D885EE350@AM0PR04MB6434.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-05-19, 09:44, Leonard Crestez wrote:
> On 03.05.2019 09:52, Viresh Kumar wrote:

> > Why add another virtual device-driver pair here? The only reason why we have
> > been adding it was to get deferred probe to work which doesn't look like the
> > case for this driver. Why not do everything from the init() routine ?
> 
> The imx-cpufreq-dt platform_driver reads from fuses (nvmem/imx-ocotp) 
> which can be theoretically be built as a module and also has clock 

I am not against making this driver a module, that is okay.

> requirements. No sure we should rely that the call to read from nvmem 
> never returns EPROBE_DEFER.

Okay, I didn't realize that we can get EPROBE_DEFER from
nvmem_cell_read_u32(). Should be fine then.

-- 
viresh
