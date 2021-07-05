Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1363BB523
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 04:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhGECYg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 22:24:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhGECYf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 4 Jul 2021 22:24:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77544613BD;
        Mon,  5 Jul 2021 02:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625451719;
        bh=nCOdqQkG5UQ9ELEuMGrQai5rcTgVU73WviH2mpknfCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OTcdkjxhu/1EaSqon4LOsiqxRvjiRfM3LTqS5m9JEc3MtH8W3TZuxBKGR1mAQpiSo
         G+hlph1+lA6RxgcNL4OUxYr+kH457wAJc6hPbP3gIG+z6W/Nrz9weHT54R+x0/SL1V
         0Pqk8OtxyO80i428JlNIFPt8jxUxCNn2XoBKb5EpzKuAxXMPXD5XKbVMIECGrhOHbo
         IG+JUFTmY6m3vyz+0GKlepcxOL3Uz62eGvSuCPGe/1m+Vlkz9teJOwsNYT7+u7DCEr
         zwc60jOZi80ln3Zse2/KUbXARNFVTK3CNNVBGKjsNMFCjh7C1B8cmpcFHTONPSBAwI
         724WADwxhO1Ow==
Date:   Mon, 5 Jul 2021 10:21:51 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 05/12] usb: otg-fsm: Fix hrtimer list corruption
Message-ID: <20210705022151.GA12125@nchen>
References: <20210701234317.26393-1-digetx@gmail.com>
 <20210701234317.26393-6-digetx@gmail.com>
 <20210703110809.GA4289@Peter>
 <29476aa3-c34e-8bf0-5eab-f7def493f329@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29476aa3-c34e-8bf0-5eab-f7def493f329@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-07-03 20:22:38, Dmitry Osipenko wrote:
> 03.07.2021 14:08, Peter Chen пишет:
> > On 21-07-02 02:43:10, Dmitry Osipenko wrote:
> >> The HNP work can be re-scheduled while it's still in-fly. This results in
> >> re-initialization of the busy work, resetting the hrtimer's list node of
> >> the work and crashing kernel with null dereference within kernel/timer
> >> once work's timer is expired. It's very easy to trigger this problem by
> >> re-plugging USB cable quickly. Initialize HNP work only once to fix this
> >> trouble.
> > 
> > Fully OTG compliance support has not maintained for years, what's the use case you
> > still want to use?
> 
> I don't have any use case for it, but I had CONFIG_USB_OTG_FSM=y and it
> was crashing kernel badly. The OTG works perfectly fine without the FSM.

You could add below at your dts to disable OTG FSM:
hnp-disable
srp-disable
adp-disable

Since there are no users for OTG FSM, it hasn't maintained for years,
I am not sure if it still works OK. If I remember correctly, the VBUS
will be off if you enable HNP, and the device at the host port will be
disconnected, that's may not your expectation.

-- 

Thanks,
Peter Chen

