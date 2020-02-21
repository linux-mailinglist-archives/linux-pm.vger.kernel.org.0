Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 424BA1677B6
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 09:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbgBUInV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 03:43:21 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:36466 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730538AbgBUInU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 03:43:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582274599; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=2uuwEllZOFN2t55iFCOv+EfXhVOJ4HA08UuWs0sOrD8=;
 b=msBpmOrL8eK+eq/dkNatIwfSCEC3ZCTRBrTweb8Q91BDNSZX15GDsBrhfQACegivsJKDll/Z
 GtEKkxGwoH3MBvqEY0gqsCzbuF1BbDIlmQAIIgNCRBkRNoXydji7bfVV3vGrM0T76S4acQyp
 aAPhOVZ2vRuLRQbDT07ZrdJ09Ps=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4f9826.7f6e24517998-smtp-out-n01;
 Fri, 21 Feb 2020 08:43:18 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 62DBFC4479F; Fri, 21 Feb 2020 08:43:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C53DC43383;
        Fri, 21 Feb 2020 08:43:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 21 Feb 2020 14:13:15 +0530
From:   okukatla@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, bjorn.andersson@linaro.org,
        daidavid1@codeaurora.org, evgreen@google.com,
        georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        ilina@codeaurora.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [V2, 2/3] interconnect: qcom: Add SC7180 interconnect provider
 driver
In-Reply-To: <5e118869.1c69fb81.c28bf.4564@mx.google.com>
References: <1577782737-32068-1-git-send-email-okukatla@codeaurora.org>
 <1577782737-32068-3-git-send-email-okukatla@codeaurora.org>
 <5e118869.1c69fb81.c28bf.4564@mx.google.com>
Message-ID: <1829865b2179f7aae3fce5e2a93902bf@codeaurora.org>
X-Sender: okukatla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-01-05 12:25, Stephen Boyd wrote:
> Quoting Odelu Kukatla (2019-12-31 00:58:56)
>> diff --git a/drivers/interconnect/qcom/sc7180.c 
>> b/drivers/interconnect/qcom/sc7180.c
>> new file mode 100644
>> index 0000000..4a398e0
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/sc7180.c
>> @@ -0,0 +1,788 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
>> + *
>> + */
>> +
>> +#include <dt-bindings/interconnect/qcom,sc7180.h>
> 
> Can you include this after linux/ headers? That is the "preferred" way
> to include headers.
> 
done.
>> +#include <linux/device.h>
>> +#include <linux/interconnect.h>
>> +#include <linux/interconnect-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
> 
> Hopefully this include isn't used and can be removed.
> 
I will remove it.
>> +#include <linux/of_platform.h>
> 
> Is this include used?
> 
I will remove it.
>> +#include <linux/platform_device.h>
>> +
>> +#include "icc-rpmh.h"
>> +#include "bcm-voter.h"
>> +
> [...]
>> +
>> +static struct qcom_icc_node *system_noc_nodes[] = {
>> +       [MASTER_SNOC_CFG] = &qhm_snoc_cfg,
>> +       [MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
>> +       [MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
>> +       [MASTER_GEM_NOC_SNOC] = &qnm_gemnoc,
>> +       [MASTER_PIMEM] = &qxm_pimem,
>> +       [SLAVE_APPSS] = &qhs_apss,
>> +       [SLAVE_SNOC_CNOC] = &qns_cnoc,
>> +       [SLAVE_SNOC_GEM_NOC_GC] = &qns_gemnoc_gc,
>> +       [SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
>> +       [SLAVE_IMEM] = &qxs_imem,
>> +       [SLAVE_PIMEM] = &qxs_pimem,
>> +       [SLAVE_SERVICE_SNOC] = &srvc_snoc,
>> +       [SLAVE_QDSS_STM] = &xs_qdss_stm,
>> +       [SLAVE_TCU] = &xs_sys_tcu_cfg,
>> +};
>> +
>> +static struct qcom_icc_desc sc7180_system_noc = {
> 
> Can this be const? And the other ones?
> yes, will change it.
>> +       .nodes = system_noc_nodes,
>> +       .num_nodes = ARRAY_SIZE(system_noc_nodes),
>> +       .bcms = system_noc_bcms,
>> +       .num_bcms = ARRAY_SIZE(system_noc_bcms),
>> +};
>> +
>> +static int qnoc_probe(struct platform_device *pdev)
>> +{
>> +       const struct qcom_icc_desc *desc;
>> +       struct icc_onecell_data *data;
>> +       struct icc_provider *provider;
>> +       struct qcom_icc_node **qnodes;
>> +       struct qcom_icc_provider *qp;
>> +       struct icc_node *node;
>> +       size_t num_nodes, i;
>> +       int ret;
>> +
>> +       desc = of_device_get_match_data(&pdev->dev);
> 
> Use device_get_match_data() instead?
> 
will update it.
>> +       if (!desc)
>> +               return -EINVAL;
>> +
>> +       qnodes = desc->nodes;
>> +       num_nodes = desc->num_nodes;
>> +
>> +       qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
>> +       if (!qp)
>> +               return -ENOMEM;
>> +
>> +       data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), 
>> GFP_KERNEL);
>> +       if (!data)
>> +               return -ENOMEM;
>> +
>> +       provider = &qp->provider;
>> +       provider->dev = &pdev->dev;
>> +       provider->set = qcom_icc_set;
>> +       provider->pre_aggregate = qcom_icc_pre_aggregate;
>> +       provider->aggregate = qcom_icc_aggregate;
>> +       provider->xlate = of_icc_xlate_onecell;
>> +       INIT_LIST_HEAD(&provider->nodes);
>> +       provider->data = data;
>> +
>> +       qp->dev = &pdev->dev;
>> +       qp->bcms = desc->bcms;
>> +       qp->num_bcms = desc->num_bcms;
>> +
>> +       qp->voter = of_bcm_voter_get(qp->dev, NULL);
>> +       if (IS_ERR(qp->voter))
>> +               return PTR_ERR(qp->voter);
>> +
>> +       ret = icc_provider_add(provider);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "error adding interconnect 
>> provider\n");
>> +               return ret;
>> +       }
>> +
>> +       for (i = 0; i < num_nodes; i++) {
>> +               size_t j;
>> +
>> +               if (!qnodes[i])
>> +                       continue;
>> +
>> +               node = icc_node_create(qnodes[i]->id);
>> +               if (IS_ERR(node)) {
>> +                       ret = PTR_ERR(node);
>> +                       goto err;
>> +               }
>> +
>> +               node->name = qnodes[i]->name;
>> +               node->data = qnodes[i];
>> +               icc_node_add(node, provider);
>> +
>> +               dev_dbg(&pdev->dev, "registered node %pK %s %d\n", 
>> node,
>> +                       qnodes[i]->name, node->id);
> 
> Is this more debug junk? Maybe if it is useful it can be part of the
> core framework instead of in this driver?
> 
>> +
>> +               /* populate links */
> 
> Useless comment.
> i will clean up this.
>> +               for (j = 0; j < qnodes[i]->num_links; j++)
>> +                       icc_link_create(node, qnodes[i]->links[j]);
>> +
>> +               data->nodes[i] = node;
>> +       }
>> +       data->num_nodes = num_nodes;
>> +
>> +       for (i = 0; i < qp->num_bcms; i++)
>> +               qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
>> +
>> +       platform_set_drvdata(pdev, qp);
>> +
>> +       dev_dbg(&pdev->dev, "Registered SC7180 ICC\n");
> 
> This driver debug message is pretty useless. Please remove it.
> i will removr it.
>> +
>> +       return ret;
> 
> return 0?
> 
>> +err:
>> +       icc_nodes_remove(provider);
>> +       icc_provider_del(provider);
>> +       return ret;
>> +}
>> +
>> +static int qnoc_remove(struct platform_device *pdev)
>> +{
>> +       struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
>> +
>> +       icc_nodes_remove(&qp->provider);
>> +       return icc_provider_del(&qp->provider);
>> +}
>> +
>> +static const struct of_device_id qnoc_of_match[] = {
>> +       { .compatible = "qcom,sc7180-aggre1-noc",
>> +         .data = &sc7180_aggre1_noc},
>> +       { .compatible = "qcom,sc7180-aggre2-noc",
>> +         .data = &sc7180_aggre2_noc},
>> +       { .compatible = "qcom,sc7180-camnoc-virt",
>> +         .data = &sc7180_camnoc_virt},
>> +       { .compatible = "qcom,sc7180-compute-noc",
>> +         .data = &sc7180_compute_noc},
>> +       { .compatible = "qcom,sc7180-config-noc",
>> +         .data = &sc7180_config_noc},
>> +       { .compatible = "qcom,sc7180-dc-noc",
>> +         .data = &sc7180_dc_noc},
>> +       { .compatible = "qcom,sc7180-gem-noc",
>> +         .data = &sc7180_gem_noc},
>> +       { .compatible = "qcom,sc7180-ipa-virt",
>> +         .data = &sc7180_ipa_virt},
>> +       { .compatible = "qcom,sc7180-mc-virt",
>> +         .data = &sc7180_mc_virt},
>> +       { .compatible = "qcom,sc7180-mmss-noc",
>> +         .data = &sc7180_mmss_noc},
>> +       { .compatible = "qcom,sc7180-npu-noc",
>> +         .data = &sc7180_npu_noc},
>> +       { .compatible = "qcom,sc7180-qup-virt",
>> +         .data = &sc7180_qup_virt},
>> +       { .compatible = "qcom,sc7180-system-noc",
>> +         .data = &sc7180_system_noc},
>> +       { },
> 
> Nitpick: Drop the comma as it's the sentinel and nothing can come 
> after.
> will remove it.
>> +};
>> +MODULE_DEVICE_TABLE(of, qnoc_of_match);
