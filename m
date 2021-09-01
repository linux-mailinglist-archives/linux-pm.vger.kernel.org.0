Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7553FE284
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 20:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345063AbhIAStF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 14:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345015AbhIAStE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 14:49:04 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B0DC061760
        for <linux-pm@vger.kernel.org>; Wed,  1 Sep 2021 11:48:07 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id B214B1F9D4;
        Wed,  1 Sep 2021 20:48:05 +0200 (CEST)
Subject: Re: [PATCH v4 1/5] interconnect: qcom: sdm660: Commonize RPM-QoS
To:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20210901121518.152481-1-y.oudjana@protonmail.com>
 <20210901121518.152481-2-y.oudjana@protonmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <9af0f031-101e-53b4-514e-9ead44320f4e@somainline.org>
Date:   Wed, 1 Sep 2021 20:48:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210901121518.152481-2-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 01/09/21 14:15, Yassine Oudjana ha scritto:
> SoCs such as MSM8996 also control bus QoS in a similar fashion to SDM660,
> with some paths being controlled by RPM and others directly by the AP.
> Move relevant functions and defines to a new object so that they can be used
> in multiple drivers.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Hey guys!

I'm waiting for the interconnect RPM-QoS commonization to be merged as I have fresh
interconnect drivers for MSM8998 and MSM8976, ready to send, that are also using
the very same QoS mechanism as SDM660.

Yassine, please check Shawn's recent patches for SDM660 interconnect, which are
fixing some bits for the QoS implementation and adding some required clocks to the
SDM660 interconnect driver.

Adding Shawn to the Ccs as to make him aware of this patch;
also adding Marijn and Konrad from SoMainline as probably interested parties.

Cheers!
- Angelo
