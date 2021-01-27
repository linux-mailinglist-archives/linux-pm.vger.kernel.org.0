Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F59306385
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 19:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344018AbhA0SpM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 13:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344017AbhA0SpK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 13:45:10 -0500
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18EDC06174A;
        Wed, 27 Jan 2021 10:44:19 -0800 (PST)
Received: from [192.168.1.101] (abaf219.neoplus.adsl.tpnet.pl [83.6.169.219])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 33EB53F0A3;
        Wed, 27 Jan 2021 19:44:17 +0100 (CET)
Subject: Re: [PATCH] thermal: qcom: tsens-v0_1: Add support for MDM9607
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210127181400.44642-1-konrad.dybcio@somainline.org>
 <YBGxgSb8TJeYH6mw@builder.lan>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
Message-ID: <e08f75be-4520-395d-599b-a2cbd7fbefe8@somainline.org>
Date:   Wed, 27 Jan 2021 19:44:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YBGxgSb8TJeYH6mw@builder.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> Afaict, there's no need to initialize base0 and base1, they are both
> assigned to before used.
>
> Also, they are temporary variables within each case (even with the
> fallthrough), so you should only need a single "base".
>
Right. Fixed, will send in a v3 (I sent a v2 shortly after this one because I misplaced the #defines).


> How about:
>
> 	mode = field_get(MDM9607_CAL_SEL_MASK, qfprom_cdata[2]);
>
> and same below.
>
> (I see that this would break the style of the file, perhaps we can clean
> that up?)
>
I'd rather not change that to keep it comparable to the downstream driver, should anything ever break and need investigation..


> qfprom_csel seems unused and uninitialized.

Fixed as well.


Konrad


