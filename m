Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4BBA177531
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 12:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgCCLSC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 06:18:02 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:35879 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgCCLSC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 06:18:02 -0500
Received: by mail-pf1-f175.google.com with SMTP id i13so1309119pfe.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 03:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6LpPu+7mzHDbzzNZ3vNWrKJy3N6+UnYE5W0wfZ5TDvA=;
        b=X9DQytk52qZ6DQRmc5okitpNMgHqG6s8o4bhvGC/XRa0ECQDG91tyC0uTDPgvD5O1k
         AUuMxfLAJyrLqXfrAp5dKlhSuhJd+75XMDpEpOhrHrfJ3hNdoOJBM9SxQNB3jHDPbsD8
         DhiRPCC1dISZWIga0LihFWuRrO+DF9g8G3LAFp5NaoxJuVYG6DS7xohhSh+k7UWyF562
         YPqgCzzzuUmbeQKhJvCRRs0x4f4+fnOrjIpvEtN8uYJfnHqRy6MgFt55MQn41GYLpstR
         fMeTQE2yvj0EyS4Bx0uHfr0FdNMEMZDwY5XPTrtOrDQpG/auu4hOrJn2TkWWAD4aZ+Pr
         r/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6LpPu+7mzHDbzzNZ3vNWrKJy3N6+UnYE5W0wfZ5TDvA=;
        b=NOVjwPOW6B877YsKEWUBkUlHqMxjyYDC74pxq1XdXdpDtEqroBboXurWJHGsY5IYUx
         9Hr/Fbfvb3cIthIrsq8/FKm+WzALSztzwvDMAIZ0JizH637bnqLV+RSUKeylEAEuZSvD
         AzuPKrmyYXQBL79E4dCbQbZdMsyKLdCcWAVRMxFYKi3vQtqvecYh4OOUr/BWmbfh49py
         nuG++rBlUhCE0LZ9vkyuo0G19WJd9E3p8RPgS/L9PKIdwXwHbCwkXbTb5XQHBeULENPO
         2TliB5umalCFTSfJaoHx0eRJ0x04gn9yCeDsHIUf9w3An0lSeMMk0ShlfnAXPLxieD4i
         e7hg==
X-Gm-Message-State: ANhLgQ3+ROHxN6ZGkC//ZLd207ybShab1bbbjA5ivK7dcseuT4qM0pcb
        IJ02HB2Z8KXkur2ZBPPA8GHC0Q==
X-Google-Smtp-Source: ADFU+vtX4ocvGPjD4lCipeCvf6Ndh/Qq0CPh8PdfYnJjc4X0n5KlKRfZpxjGrKkVvOS0v1sBH1rFJA==
X-Received: by 2002:a63:4103:: with SMTP id o3mr3271939pga.199.1583234279527;
        Tue, 03 Mar 2020 03:17:59 -0800 (PST)
Received: from localhost ([122.167.24.230])
        by smtp.gmail.com with ESMTPSA id d4sm2138730pjg.19.2020.03.03.03.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 03:17:58 -0800 (PST)
Date:   Tue, 3 Mar 2020 16:47:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/3] Convert i.MX6Q cpufreq to use nvmem API
Message-ID: <20200303111756.eikekt7vg2js7emw@vireshk-i7>
References: <1583201690-16068-1-git-send-email-peng.fan@nxp.com>
 <20200303054547.4wpnzmgnuo7jd2qa@vireshk-i7>
 <AM0PR04MB4481FDAD041F6476FFFC0F6788E40@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4481FDAD041F6476FFFC0F6788E40@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-03-20, 06:16, Peng Fan wrote:
> Hi Viresh,
> 
> > Subject: Re: [PATCH 0/3] Convert i.MX6Q cpufreq to use nvmem API
> > 
> > On 03-03-20, 10:14, peng.fan@nxp.com wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Use nvmem API is better compared with direclty accessing OCOTP registers.
> > > nvmem could handle OCOTP clk, defer probe.
> > >
> > > Patch 1/3 is dts changes to add nvmem related properties Patch 2/3 is
> > > a bug fix Patch 3/3 is convert to nvmem API
> > 
> > Should I apply patch 2 and 3 ? And you can take 1/3 via ARM Soc tree as this
> > shouldn't break anything.
> 
> Please take patch 2 and 3. Without patch 1, it just use legacy method,
> not break things.

Applied. Thanks.

-- 
viresh
