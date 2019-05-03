Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C274C12811
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 08:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfECGx3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 02:53:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39845 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfECGx3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2019 02:53:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id w22so956402pgi.6
        for <linux-pm@vger.kernel.org>; Thu, 02 May 2019 23:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mrZORLKQrD0+dA9tzmgTZsIYZ2E2nmGSbLpObi4k/no=;
        b=b5GBuW8j0AOo084lBENajV86iGsi8yHS3gw33fr5OLy+n/GiN3k4Fa3b5zQHJoRscd
         E/TcH04HbvzS5TqfMxXoiGJZOuIwjeiKNRagV2fdLFVJp8Py8Awf0ZNPn0DODo2LsbrO
         01SdIHQ1qoo5FlRlnw5IaO+rYXkIbt2aVU9DLs6l1T1ba3iTac1F0wmGAxSZQ8NPlQKE
         T+RfCX+fX6fjrZ+EY/phUmSkzV1YOSWQRqA+7+I7QOWqZNvEtePl4POhlMLW/aZkp+dk
         FzP7REC1ZikawPLuvyOtkA96qxN4jYxOpgRA0W+iNPcZ7j/3aMfWy+zluHST0m02Jvg4
         T5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mrZORLKQrD0+dA9tzmgTZsIYZ2E2nmGSbLpObi4k/no=;
        b=B1uqbOxaGo4FyzuVHHq5n+s8+cZi9deWyh9OASUYiqiKcEBRVKXngVzS5HUcHvinKw
         j56jmzNNixtpmM5YeApB7GZUnQdUyGHCn6snmag5JJaFG3Yhrmnwt30HnkN3XUbuOugF
         1VZXsqGkhr8G5C/ImdHfAP8w3y+54lKvDT3Nu3eU4ZWPABZappzbLYowJvy//mRvHHQx
         I4gXzcW3JAb5caPJlC80Q8elsqFHhgmZZpm1nny1+OBAfMmdQtlltp0Da7/r4rozkE4S
         SK9XOFzmoxBAWcddt8SonUa4xNpCaaO0dQyhLW6vOjW5cxKBvGOqrNKvMK35xXvOv8Iz
         YrFg==
X-Gm-Message-State: APjAAAXWiTSbLaWJ1C4g6IsKs5Ujx1UZpyzxaPIS226phiSim07F/oBi
        5wvashVjrCJ5SWJEpGCigrA+aoXG8h4=
X-Google-Smtp-Source: APXvYqy4Bp3FMEGX6Ci1dt3HcOdM4s0sFs1cVaN1t6Nuk43F5Ep6L09TGrGiIjjKOrxmQjmvzfasew==
X-Received: by 2002:a62:448d:: with SMTP id m13mr9024302pfi.182.1556866408984;
        Thu, 02 May 2019 23:53:28 -0700 (PDT)
Received: from localhost ([171.61.121.242])
        by smtp.gmail.com with ESMTPSA id s85sm2357007pfa.23.2019.05.02.23.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 23:53:28 -0700 (PDT)
Date:   Fri, 3 May 2019 12:23:26 +0530
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
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8mq: Add cpu speed grading and all
 OPPs
Message-ID: <20190503065326.cdammgpkykikencu@vireshk-i7>
References: <cover.1556836868.git.leonard.crestez@nxp.com>
 <59286bf8fcdca332df4004c3d141727f0188ad6f.1556836868.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59286bf8fcdca332df4004c3d141727f0188ad6f.1556836868.git.leonard.crestez@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-05-19, 22:44, Leonard Crestez wrote:
> Add nvmem-cells reference to cpu and fill the OPP table with all known
> OPPs.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
