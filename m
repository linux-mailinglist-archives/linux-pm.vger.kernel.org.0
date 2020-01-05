Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 598F1130657
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2020 07:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgAEGzj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jan 2020 01:55:39 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35582 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgAEGzj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jan 2020 01:55:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so20613770plt.2
        for <linux-pm@vger.kernel.org>; Sat, 04 Jan 2020 22:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=BO1WZysMmnkDiZyMpnrijand6L7VBnHht4X1wph901M=;
        b=EYYemt4gC82sIRviMZwJ6bAWs/sPxzJmC6hKjL2s0IyeerRg/xnFHCApBt8noAvW2U
         TD0QWn4eTp3tPdWN3QMKWGZ5VU4CF5OiIOb6u8ISrfTM5J4il0zL29k9tqzFwHHjGviB
         DUuWEebX76f26QzWsjopJJS9O88HfBZbeZcfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=BO1WZysMmnkDiZyMpnrijand6L7VBnHht4X1wph901M=;
        b=C87Xp2iNTbp7vVVBNvZCRzpShIl5HZ2MM1reuS2coHtrtFByoBAUHl2NnxHuVaINBm
         Y5au0dfWevid1iH9GQ79bVvxusjCXluOtbgHtkIQqaCezXDS6xIrZj1gpCknM131VjYj
         HOXna6eutbDNCX0nlBfHAYWDGQep3sNPDD/TN1FwIOuqSliUtgaMORZPXZVN8jDefLcC
         qk+MyeWtIU2ukDRn8t1fJS0xwE2KhVY07Lz6ZLe9Se49KudMSVHb7wlobFaO8Rx3qguw
         r0YOWw1QV8AcdnPLZo9zeNpdDIjwPKVmfnFscPI3bd0z/8aFdm+woX6Aqb2yB7FTCTiw
         RqWA==
X-Gm-Message-State: APjAAAUl3Udnji7uVIZu0fYEneypc+PgFwHJCCqPXPpB/CHuD6OkVcLb
        VFPZsq61JoSOjuQ+s9mag8svHg==
X-Google-Smtp-Source: APXvYqw5dtRFwrji0lraFoWIcYPcyRwDIOD1NW1KT9D1onxeHicXKbQR/zeVI6PHcVRjLxy3lI34OA==
X-Received: by 2002:a17:90a:c211:: with SMTP id e17mr37750675pjt.14.1578207338520;
        Sat, 04 Jan 2020 22:55:38 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u2sm67988487pgc.19.2020.01.04.22.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 22:55:37 -0800 (PST)
Message-ID: <5e118869.1c69fb81.c28bf.4564@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1577782737-32068-3-git-send-email-okukatla@codeaurora.org>
References: <1577782737-32068-1-git-send-email-okukatla@codeaurora.org> <1577782737-32068-3-git-send-email-okukatla@codeaurora.org>
Cc:     ilina@codeaurora.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-arm-msm-owner@vger.kernel.org,
        Odelu Kukatla <okukatla@codeaurora.org>
Subject: Re: [V2, 2/3] interconnect: qcom: Add SC7180 interconnect provider driver
To:     Andy Gross <agross@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        bjorn.andersson@linaro.org, daidavid1@codeaurora.org,
        evgreen@google.com, georgi.djakov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Sat, 04 Jan 2020 22:55:36 -0800
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Odelu Kukatla (2019-12-31 00:58:56)
> diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qc=
om/sc7180.c
> new file mode 100644
> index 0000000..4a398e0
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sc7180.c
> @@ -0,0 +1,788 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
> + *
> + */
> +
> +#include <dt-bindings/interconnect/qcom,sc7180.h>

Can you include this after linux/ headers? That is the "preferred" way
to include headers.

> +#include <linux/device.h>
> +#include <linux/interconnect.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>

Hopefully this include isn't used and can be removed.

> +#include <linux/of_platform.h>

Is this include used?

> +#include <linux/platform_device.h>
> +
> +#include "icc-rpmh.h"
> +#include "bcm-voter.h"
> +
[...]
> +
> +static struct qcom_icc_node *system_noc_nodes[] =3D {
> +       [MASTER_SNOC_CFG] =3D &qhm_snoc_cfg,
> +       [MASTER_A1NOC_SNOC] =3D &qnm_aggre1_noc,
> +       [MASTER_A2NOC_SNOC] =3D &qnm_aggre2_noc,
> +       [MASTER_GEM_NOC_SNOC] =3D &qnm_gemnoc,
> +       [MASTER_PIMEM] =3D &qxm_pimem,
> +       [SLAVE_APPSS] =3D &qhs_apss,
> +       [SLAVE_SNOC_CNOC] =3D &qns_cnoc,
> +       [SLAVE_SNOC_GEM_NOC_GC] =3D &qns_gemnoc_gc,
> +       [SLAVE_SNOC_GEM_NOC_SF] =3D &qns_gemnoc_sf,
> +       [SLAVE_IMEM] =3D &qxs_imem,
> +       [SLAVE_PIMEM] =3D &qxs_pimem,
> +       [SLAVE_SERVICE_SNOC] =3D &srvc_snoc,
> +       [SLAVE_QDSS_STM] =3D &xs_qdss_stm,
> +       [SLAVE_TCU] =3D &xs_sys_tcu_cfg,
> +};
> +
> +static struct qcom_icc_desc sc7180_system_noc =3D {

Can this be const? And the other ones?

> +       .nodes =3D system_noc_nodes,
> +       .num_nodes =3D ARRAY_SIZE(system_noc_nodes),
> +       .bcms =3D system_noc_bcms,
> +       .num_bcms =3D ARRAY_SIZE(system_noc_bcms),
> +};
> +
> +static int qnoc_probe(struct platform_device *pdev)
> +{
> +       const struct qcom_icc_desc *desc;
> +       struct icc_onecell_data *data;
> +       struct icc_provider *provider;
> +       struct qcom_icc_node **qnodes;
> +       struct qcom_icc_provider *qp;
> +       struct icc_node *node;
> +       size_t num_nodes, i;
> +       int ret;
> +
> +       desc =3D of_device_get_match_data(&pdev->dev);

Use device_get_match_data() instead?

> +       if (!desc)
> +               return -EINVAL;
> +
> +       qnodes =3D desc->nodes;
> +       num_nodes =3D desc->num_nodes;
> +
> +       qp =3D devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
> +       if (!qp)
> +               return -ENOMEM;
> +
> +       data =3D devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_K=
ERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       provider =3D &qp->provider;
> +       provider->dev =3D &pdev->dev;
> +       provider->set =3D qcom_icc_set;
> +       provider->pre_aggregate =3D qcom_icc_pre_aggregate;
> +       provider->aggregate =3D qcom_icc_aggregate;
> +       provider->xlate =3D of_icc_xlate_onecell;
> +       INIT_LIST_HEAD(&provider->nodes);
> +       provider->data =3D data;
> +
> +       qp->dev =3D &pdev->dev;
> +       qp->bcms =3D desc->bcms;
> +       qp->num_bcms =3D desc->num_bcms;
> +
> +       qp->voter =3D of_bcm_voter_get(qp->dev, NULL);
> +       if (IS_ERR(qp->voter))
> +               return PTR_ERR(qp->voter);
> +
> +       ret =3D icc_provider_add(provider);
> +       if (ret) {
> +               dev_err(&pdev->dev, "error adding interconnect provider\n=
");
> +               return ret;
> +       }
> +
> +       for (i =3D 0; i < num_nodes; i++) {
> +               size_t j;
> +
> +               if (!qnodes[i])
> +                       continue;
> +
> +               node =3D icc_node_create(qnodes[i]->id);
> +               if (IS_ERR(node)) {
> +                       ret =3D PTR_ERR(node);
> +                       goto err;
> +               }
> +
> +               node->name =3D qnodes[i]->name;
> +               node->data =3D qnodes[i];
> +               icc_node_add(node, provider);
> +
> +               dev_dbg(&pdev->dev, "registered node %pK %s %d\n", node,
> +                       qnodes[i]->name, node->id);

Is this more debug junk? Maybe if it is useful it can be part of the
core framework instead of in this driver?

> +
> +               /* populate links */

Useless comment.

> +               for (j =3D 0; j < qnodes[i]->num_links; j++)
> +                       icc_link_create(node, qnodes[i]->links[j]);
> +
> +               data->nodes[i] =3D node;
> +       }
> +       data->num_nodes =3D num_nodes;
> +
> +       for (i =3D 0; i < qp->num_bcms; i++)
> +               qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
> +
> +       platform_set_drvdata(pdev, qp);
> +
> +       dev_dbg(&pdev->dev, "Registered SC7180 ICC\n");

This driver debug message is pretty useless. Please remove it.

> +
> +       return ret;

return 0?

> +err:
> +       icc_nodes_remove(provider);
> +       icc_provider_del(provider);
> +       return ret;
> +}
> +
> +static int qnoc_remove(struct platform_device *pdev)
> +{
> +       struct qcom_icc_provider *qp =3D platform_get_drvdata(pdev);
> +
> +       icc_nodes_remove(&qp->provider);
> +       return icc_provider_del(&qp->provider);
> +}
> +
> +static const struct of_device_id qnoc_of_match[] =3D {
> +       { .compatible =3D "qcom,sc7180-aggre1-noc",
> +         .data =3D &sc7180_aggre1_noc},
> +       { .compatible =3D "qcom,sc7180-aggre2-noc",
> +         .data =3D &sc7180_aggre2_noc},
> +       { .compatible =3D "qcom,sc7180-camnoc-virt",
> +         .data =3D &sc7180_camnoc_virt},
> +       { .compatible =3D "qcom,sc7180-compute-noc",
> +         .data =3D &sc7180_compute_noc},
> +       { .compatible =3D "qcom,sc7180-config-noc",
> +         .data =3D &sc7180_config_noc},
> +       { .compatible =3D "qcom,sc7180-dc-noc",
> +         .data =3D &sc7180_dc_noc},
> +       { .compatible =3D "qcom,sc7180-gem-noc",
> +         .data =3D &sc7180_gem_noc},
> +       { .compatible =3D "qcom,sc7180-ipa-virt",
> +         .data =3D &sc7180_ipa_virt},
> +       { .compatible =3D "qcom,sc7180-mc-virt",
> +         .data =3D &sc7180_mc_virt},
> +       { .compatible =3D "qcom,sc7180-mmss-noc",
> +         .data =3D &sc7180_mmss_noc},
> +       { .compatible =3D "qcom,sc7180-npu-noc",
> +         .data =3D &sc7180_npu_noc},
> +       { .compatible =3D "qcom,sc7180-qup-virt",
> +         .data =3D &sc7180_qup_virt},
> +       { .compatible =3D "qcom,sc7180-system-noc",
> +         .data =3D &sc7180_system_noc},
> +       { },

Nitpick: Drop the comma as it's the sentinel and nothing can come after.

> +};
> +MODULE_DEVICE_TABLE(of, qnoc_of_match);
