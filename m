Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3AB50A969
	for <lists+linux-pm@lfdr.de>; Thu, 21 Apr 2022 21:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiDUToq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Apr 2022 15:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbiDUTop (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2022 15:44:45 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9D94BB88
        for <linux-pm@vger.kernel.org>; Thu, 21 Apr 2022 12:41:54 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id h12so2340569plf.12
        for <linux-pm@vger.kernel.org>; Thu, 21 Apr 2022 12:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ICt5XunHqsELIdqZvSPeKFkS3NdL0ipmf4jJkro4jDI=;
        b=jzhcFj9g3o0+nQIg/v13SYDCUCYJE/XGVZXklvbwKm28Ii0M4KhrUbiZ1Uos7NM44D
         Y15MkEjTOPa8akkUnkjCMXU4EZ2iP6WoTEsKNYAeFD04rEySeqOAYrQ2TyFZMfd8c7jC
         CH1jmS3RaCKaU+1gWXr1SWNMIVz6UHDk5Na5M5GgIgVqqKLrhqOHKbPmlHQSFKWHRgKG
         ScJ3mJZd1iYQ9/WUUiPSEKgFkTR6DhWuU0JaRZ4xmDYp7cEdF6KM+4KIP4HbreCxfiV5
         PTRblWsbZCOHp+XGNz9D/J6MKBFG8a85yVXmiOh2001n6MWwVKUC8nCYvtYcsNKXzf8/
         JUyQ==
X-Gm-Message-State: AOAM530idKk5mgavgnNH+YZ3sUzpt8JpEVfNcM1md4XF90/kU81lflTk
        um05sD8pIMSQZxRxYRuC9Piu0w==
X-Google-Smtp-Source: ABdhPJxpOKBLlWVUs2NzoRXMdBxSn5hTiUFvJaFcN6Sw89Ynkamt2rs5a60P62l9RvRwU+EuGV/FjQ==
X-Received: by 2002:a17:902:b596:b0:158:f23a:c789 with SMTP id a22-20020a170902b59600b00158f23ac789mr927819pls.57.1650570113700;
        Thu, 21 Apr 2022 12:41:53 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id v14-20020a17090a6b0e00b001d2bff34228sm3703433pjj.9.2022.04.21.12.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:41:53 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>
Subject: Re: [PATCH v24 0/7] soc: mediatek: SVS: introduce MTK SVS
In-Reply-To: <3d463c8b099fdb1c9a0df9e615a8ca1d8a034120.camel@mediatek.com>
References: <20220420102044.10832-1-roger.lu@mediatek.com>
 <7hczhbe3wn.fsf@baylibre.com>
 <3d463c8b099fdb1c9a0df9e615a8ca1d8a034120.camel@mediatek.com>
Date:   Thu, 21 Apr 2022 12:41:52 -0700
Message-ID: <7hsfq6ql4v.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Roger,

Roger Lu <roger.lu@mediatek.com> writes:

> On Wed, 2022-04-20 at 16:22 -0700, Kevin Hilman wrote:

[...]

>> That being said, it would be really nice to see an integration tree
>> where this was all tested on mainline (e.g. v5.17, or v5.18-rc)
>> 
>> For example, I can apply this to v5.18-rc2 and boot on my mt8183-pumpkin
>> board, it fails to probe[1] because there is no CCI node in the upstream
>> mt8183.dtsi.
>> 
>> I'm assuming this series is also not very useful without the CPUfreq
>> series from Rex, so being able to test this, CCI and CPUfreq together on
>> MT8183 on a mainline kernel would be very helpful.
>> 
>> Kevin
>> 
>> [1]
>> [    0.573332] mtk-svs 1100b000.svs: cannot find cci node
>> [    0.574061] mtk-svs 1100b000.svs: error -ENODEV: svs platform probe fail
>
> Just share. I've tested this series on below two platforms and it works as
> expected.
> - mt8183-Krane (kernel-v5.10)
> - mt8192-Hayato (kernel-v5.4)

Unfortunately testing on v5.4 and v5.10 with lots of other additional
out-of-tree patches does not give much confidence that this series works
with upstream, especially when I've given a few reasons why it will not
work uptream.

The examples I gave above for CCI and CPUs/cluster disable are good
examples, but another one I forgot to mention is the dependency on Mali.
The SVS driver will never probe because it also depens on a "mali" node,
which doesn't exist upstream either (but panfrost does, and acutually
loads/probes fine on v5.17/v5.18) so this should be fixed to work with
upstream panfrost.

IMO, in order for this to be merged upstream, it should at least have
some basic validation with upstream, and so far I have not even been
able to make it successfuly probe.  To do that, you will need to either
provide a list of the dependencies for testing this with mainline
(e.g. CCI series, CPUfreq series, any DT changes), or even better, an
integration tree based on recent mainline (e.g. v5.17 stable, or
v5.18-rc) which shows all the patches (in addition to this series) used
to validate this on mainline.

Thanks,

Kevin



