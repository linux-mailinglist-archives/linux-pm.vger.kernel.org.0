Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6305863A559
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 10:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiK1Jqw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Nov 2022 04:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiK1Jqv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2022 04:46:51 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F295A19282;
        Mon, 28 Nov 2022 01:46:49 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 36302851CF;
        Mon, 28 Nov 2022 10:46:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669628807;
        bh=e7XPNU+P63BrI5MrDGT/sQA7/99yH4xaM94P9mzp/RM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ryGubBkDsz6zrW8iEYhkdjOPhkHW3CyWMq0I+KbsiiSBihD+MwZ9/xW8nDYD917+v
         dsFj0cOtSb74W/m/ggjdCi5ZbAHP7OumQTqPuSDT76Z+vXFqEsvtoRcRwJk/SFnWrK
         ZAlrXIzMbFq1x6bY+4eCYijCc4ubc3F58qAwPfXBFbaPZy86k4sNOa7dRNEuQOkhpm
         RjVwffv3E+Ur7gD4NBXMw9OoEPI7UUpbMBaMophqBHzQS76+iQtsoacCPv6LMzgcqk
         lWx9+thfM3h/Zuen5nzrgSTadVXVeSfmL4lzXQCYtiA8FEY7YSOWy646ag56KF3SyY
         C+AhYmeDko/tQ==
Message-ID: <9d5c9ced-3ea5-414e-11f0-ab5b843f7482@denx.de>
Date:   Mon, 28 Nov 2022 10:35:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 4/5] arm64: dts: imx8m: Add TMU phandle to calibration
 data in OCOTP
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adam Ford <aford173@gmail.com>, Alice Guo <alice.guo@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Jun <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org
References: <20221126224740.311625-1-marex@denx.de>
 <20221126224740.311625-4-marex@denx.de> <12103021.O9o76ZdvQC@steina-w>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <12103021.O9o76ZdvQC@steina-w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/28/22 09:34, Alexander Stein wrote:
> Hi Marek,

Hi,

> Am Samstag, 26. November 2022, 23:47:39 CET schrieb Marek Vasut:
>> The TMU TASR, TCALIVn, TRIM registers must be explicitly programmed with
>> calibration values in OCOTP. Add the OCOTP calibration values phandle so
>> the TMU driver can perform this programming.
>>
>> The MX8MM/MX8MN TMUv1 uses only one OCOTP cell, while MX8MP TMUv2 uses 4.
> 
> Is there any source for the fuse addresses? I can only find
> OCOTP_OCOTP_HW_OCOTP_ANA1 and a calibration description in TMU section in the
> IMX8MNRM Rev 2, but I can't find any fuse for imx8mm and imx8mp.

See 5/5 in this series, the offsets are pulled from U-Boot. The 
documentation seems to be lacking in this case, I couldn't find anything 
there either.
