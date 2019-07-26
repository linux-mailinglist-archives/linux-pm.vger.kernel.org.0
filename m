Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B91EF763A2
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 12:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfGZKgH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 06:36:07 -0400
Received: from onstation.org ([52.200.56.107]:52052 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfGZKgH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Jul 2019 06:36:07 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 458643E911;
        Fri, 26 Jul 2019 10:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1564137366;
        bh=lKvd7xwHN2gTtBvSBeM80nkC5+jI2IdP2zf9IWcj8NI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DwJAR0l/PlTB8EKtJeyHiFIrEplJUNzBELIsGzBbyaeN0ET539lJkNE8ewsKzw7IO
         bqIsQ4nMVsWps0/XoPEAe3PKLqr+5O24jkruC/66WXF+F9K9XuyHmcDJ14z7qAgMZH
         YyiT7dtR45ZxeDvE0fBNU1pmyozMlJ4lgCdvGZBg=
Date:   Fri, 26 Jul 2019 06:36:05 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, marc.w.gonzalez@free.fr,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 00/15] thermal: qcom: tsens: Add interrupt support
Message-ID: <20190726103605.GB3327@onstation.org>
References: <cover.1564091601.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Amit,

On Fri, Jul 26, 2019 at 03:48:35AM +0530, Amit Kucheria wrote:
> Add interrupt support to TSENS. The first 6 patches are general fixes and
> cleanups to the driver before interrupt support is introduced.
> 
> This series has been developed against qcs404 and sdm845 and then tested on
> msm8916. Testing on msm8998 and msm8974 would be appreciated since I don't
> have hardware handy. Further, I plan to test on msm8996 and also submit to
> kernelci.
> 
> I'm sending this out for more review to get help with testing.

I can test this on msm8974 for you using a Nexus 5. Here's what I've
done so far:

The device tree nodes appear in sysfs:

/ # ls -1 /sys/class/thermal/
cooling_device0
cooling_device1
thermal_zone0
thermal_zone1
thermal_zone2
thermal_zone3
thermal_zone4
thermal_zone5
thermal_zone6
thermal_zone7
thermal_zone8
thermal_zone9

The various temperatures were in the upper 40s and I threw some work at
all four CPU cores to warm up the phone and watched the various
temperatures rise:

/ # for i in $(seq 0 9) ; do
> TYPE=$(cat /sys/class/thermal/thermal_zone$i/type)
> TEMP=$(cat /sys/class/thermal/thermal_zone$i/temp)
> echo "$TYPE = $TEMP"
> done
cpu-thermal0 = 66000
cpu-thermal1 = 66000
cpu-thermal2 = 66000
cpu-thermal3 = 66000
q6-dsp-thermal = 60000
modemtx-thermal = 57000
video-thermal = 61000
wlan-thermal = 65000
gpu-thermal-top = 61000
gpu-thermal-bottom = 59000

To test the interrupt support, I lowered all of the temperature trips to
51C but I'm not sure where to read that notification. I assume one of
the cooling devices or a governor should be started? Sorry but I haven't
done any work in the thermal subsystem yet and I'm short on time this
morning to investigate right now.

Brian
