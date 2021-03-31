Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C557C34FBBD
	for <lists+linux-pm@lfdr.de>; Wed, 31 Mar 2021 10:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbhCaIgG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Mar 2021 04:36:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47862 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhCaIfl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Mar 2021 04:35:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V8YeH0191898;
        Wed, 31 Mar 2021 08:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=fJUE+tfLrss/0EkhnZ841apdb4MVF7YrOlqonUaz8BY=;
 b=Vn4Hj4rMViULZvsE3PJZiPUqMpXshJvxcVvfZn2bQX0w4YtqId5pV+0azcsQ59+o29pU
 L5sn8REGiPSct+AYkaOiP/UVuvhjkOh7/RUxX6zpejZfsbg2ps/aKjkfIbCROXFhnat/
 02alHR8JmtfnkbIpfsVeDqLAwjdy3+cywhuyiesf2x+pZYPusUeiFRIaHtbzGD1+p+7M
 JyjNNUMSK1nlBNR1gGJTPLlnWECvWlvrrvplGo0lwai/SGfNzQAFMdU2V2JPt8aFj26f
 yfXoQ0KuBL2FPYe9p1wSmoksdtl4/fRM7asTeMaJxzKCBCdyWB/HKdtfAnTgqgDDUe8F Pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37mab3he0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 08:35:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12V8YrVC163398;
        Wed, 31 Mar 2021 08:35:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 37mac8cp4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 08:35:33 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12V8ZVRc020970;
        Wed, 31 Mar 2021 08:35:31 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Mar 2021 08:35:29 +0000
Date:   Wed, 31 Mar 2021 11:35:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [kbuild] Re: [PATCH v13 1/9] drivers: thermal: tsens: Add VER_0
 tsens version
Message-ID: <20210331083520.GG2088@kadam>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <20210324214404.798-2-ansuelsmth@gmail.com>
Message-ID-Hash: UPKCZR5V7TJKRDAQAMRKIFNEGQ245FKB
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310062
X-Proofpoint-ORIG-GUID: NZteVxgOtUQaMe3O-4aatKbMuzXmPLKq
X-Proofpoint-GUID: NZteVxgOtUQaMe3O-4aatKbMuzXmPLKq
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310062
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ansuel,

url:    https://github.com/0day-ci/linux/commits/Ansuel-Smith/drivers-thermal-tsens-Add-VER_0-tsens-version/20210325-064422
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git  for-next
config: riscv-randconfig-m031-20210330 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/thermal/qcom/tsens.c:792 init_common() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +792 drivers/thermal/qcom/tsens.c

a7ff82976122eb Amit Kucheria 2020-04-29  741  int __init init_common(struct tsens_priv *priv)
a7ff82976122eb Amit Kucheria 2020-04-29  742  {
a7ff82976122eb Amit Kucheria 2020-04-29  743  	void __iomem *tm_base, *srot_base;
a7ff82976122eb Amit Kucheria 2020-04-29  744  	struct device *dev = priv->dev;
a7ff82976122eb Amit Kucheria 2020-04-29  745  	u32 ver_minor;
a7ff82976122eb Amit Kucheria 2020-04-29  746  	struct resource *res;
a7ff82976122eb Amit Kucheria 2020-04-29  747  	u32 enabled;
a7ff82976122eb Amit Kucheria 2020-04-29  748  	int ret, i, j;
a7ff82976122eb Amit Kucheria 2020-04-29  749  	struct platform_device *op = of_find_device_by_node(priv->dev->of_node);
a7ff82976122eb Amit Kucheria 2020-04-29  750  
a7ff82976122eb Amit Kucheria 2020-04-29  751  	if (!op)
a7ff82976122eb Amit Kucheria 2020-04-29  752  		return -EINVAL;
a7ff82976122eb Amit Kucheria 2020-04-29  753  
a7ff82976122eb Amit Kucheria 2020-04-29  754  	if (op->num_resources > 1) {
a7ff82976122eb Amit Kucheria 2020-04-29  755  		/* DT with separate SROT and TM address space */
a7ff82976122eb Amit Kucheria 2020-04-29  756  		priv->tm_offset = 0;
a7ff82976122eb Amit Kucheria 2020-04-29  757  		res = platform_get_resource(op, IORESOURCE_MEM, 1);
a7ff82976122eb Amit Kucheria 2020-04-29  758  		srot_base = devm_ioremap_resource(dev, res);
a7ff82976122eb Amit Kucheria 2020-04-29  759  		if (IS_ERR(srot_base)) {
a7ff82976122eb Amit Kucheria 2020-04-29  760  			ret = PTR_ERR(srot_base);
a7ff82976122eb Amit Kucheria 2020-04-29  761  			goto err_put_device;
a7ff82976122eb Amit Kucheria 2020-04-29  762  		}
a7ff82976122eb Amit Kucheria 2020-04-29  763  
a7ff82976122eb Amit Kucheria 2020-04-29  764  		priv->srot_map = devm_regmap_init_mmio(dev, srot_base,
a7ff82976122eb Amit Kucheria 2020-04-29  765  						       &tsens_srot_config);
a7ff82976122eb Amit Kucheria 2020-04-29  766  		if (IS_ERR(priv->srot_map)) {
a7ff82976122eb Amit Kucheria 2020-04-29  767  			ret = PTR_ERR(priv->srot_map);
a7ff82976122eb Amit Kucheria 2020-04-29  768  			goto err_put_device;
a7ff82976122eb Amit Kucheria 2020-04-29  769  		}
a7ff82976122eb Amit Kucheria 2020-04-29  770  	} else {
a7ff82976122eb Amit Kucheria 2020-04-29  771  		/* old DTs where SROT and TM were in a contiguous 2K block */
a7ff82976122eb Amit Kucheria 2020-04-29  772  		priv->tm_offset = 0x1000;
a7ff82976122eb Amit Kucheria 2020-04-29  773  	}
a7ff82976122eb Amit Kucheria 2020-04-29  774  
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  775  	if (tsens_version(priv) >= VER_0_1) {
a7ff82976122eb Amit Kucheria 2020-04-29  776  		res = platform_get_resource(op, IORESOURCE_MEM, 0);
a7ff82976122eb Amit Kucheria 2020-04-29  777  		tm_base = devm_ioremap_resource(dev, res);
a7ff82976122eb Amit Kucheria 2020-04-29  778  		if (IS_ERR(tm_base)) {
a7ff82976122eb Amit Kucheria 2020-04-29  779  			ret = PTR_ERR(tm_base);
a7ff82976122eb Amit Kucheria 2020-04-29  780  			goto err_put_device;
a7ff82976122eb Amit Kucheria 2020-04-29  781  		}
a7ff82976122eb Amit Kucheria 2020-04-29  782  
a7ff82976122eb Amit Kucheria 2020-04-29  783  		priv->tm_map = devm_regmap_init_mmio(dev, tm_base, &tsens_config);
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  784  	} else { /* VER_0 share the same gcc regs using a syscon */
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  785  		struct device *parent = priv->dev->parent;
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  786  
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  787  		if (parent)
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  788  			priv->tm_map = syscon_node_to_regmap(parent->of_node);
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  789  	}
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  790  
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  791  	if (IS_ERR_OR_NULL(priv->tm_map)) {

This used to be an IS_ERR() check, but now if "priv->tm_map" is NULL
we short cut the rest of the function and return success.  It's hard to
tell without more context if that's intentional or if it should be
something like:

		if (IS_ERR_OR_NULL(priv->tm_map)) {
			if (!priv->tm_map)
				ret = -ENODEV;
			else
				ret = PTR_ERR(priv->tm_map);
			goto err_put_device;
		}

a7ff82976122eb Amit Kucheria 2020-04-29 @792  		ret = PTR_ERR(priv->tm_map);
a7ff82976122eb Amit Kucheria 2020-04-29  793  		goto err_put_device;
a7ff82976122eb Amit Kucheria 2020-04-29  794  	}
a7ff82976122eb Amit Kucheria 2020-04-29  795  
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  796  	/* VER_0 have only tm_map */
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  797  	if (!priv->srot_map)
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  798  		priv->srot_map = priv->tm_map;
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  799  
a7ff82976122eb Amit Kucheria 2020-04-29  800  	if (tsens_version(priv) > VER_0_1) {
a7ff82976122eb Amit Kucheria 2020-04-29  801  		for (i = VER_MAJOR; i <= VER_STEP; i++) {
a7ff82976122eb Amit Kucheria 2020-04-29  802  			priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
a7ff82976122eb Amit Kucheria 2020-04-29  803  							      priv->fields[i]);
a7ff82976122eb Amit Kucheria 2020-04-29  804  			if (IS_ERR(priv->rf[i]))
a7ff82976122eb Amit Kucheria 2020-04-29  805  				return PTR_ERR(priv->rf[i]);
a7ff82976122eb Amit Kucheria 2020-04-29  806  		}
a7ff82976122eb Amit Kucheria 2020-04-29  807  		ret = regmap_field_read(priv->rf[VER_MINOR], &ver_minor);
a7ff82976122eb Amit Kucheria 2020-04-29  808  		if (ret)
a7ff82976122eb Amit Kucheria 2020-04-29  809  			goto err_put_device;
a7ff82976122eb Amit Kucheria 2020-04-29  810  	}
a7ff82976122eb Amit Kucheria 2020-04-29  811  
a7ff82976122eb Amit Kucheria 2020-04-29  812  	priv->rf[TSENS_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
a7ff82976122eb Amit Kucheria 2020-04-29  813  						     priv->fields[TSENS_EN]);
a7ff82976122eb Amit Kucheria 2020-04-29  814  	if (IS_ERR(priv->rf[TSENS_EN])) {
a7ff82976122eb Amit Kucheria 2020-04-29  815  		ret = PTR_ERR(priv->rf[TSENS_EN]);
a7ff82976122eb Amit Kucheria 2020-04-29  816  		goto err_put_device;
a7ff82976122eb Amit Kucheria 2020-04-29  817  	}
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  818  	/* in VER_0 TSENS need to be explicitly enabled */
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  819  	if (tsens_version(priv) == VER_0)
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  820  		regmap_field_write(priv->rf[TSENS_EN], 1);
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  821  
a7ff82976122eb Amit Kucheria 2020-04-29  822  	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
a7ff82976122eb Amit Kucheria 2020-04-29  823  	if (ret)
a7ff82976122eb Amit Kucheria 2020-04-29  824  		goto err_put_device;
a7ff82976122eb Amit Kucheria 2020-04-29  825  	if (!enabled) {
a7ff82976122eb Amit Kucheria 2020-04-29  826  		dev_err(dev, "%s: device not enabled\n", __func__);
a7ff82976122eb Amit Kucheria 2020-04-29  827  		ret = -ENODEV;
a7ff82976122eb Amit Kucheria 2020-04-29  828  		goto err_put_device;
a7ff82976122eb Amit Kucheria 2020-04-29  829  	}
a7ff82976122eb Amit Kucheria 2020-04-29  830  
a7ff82976122eb Amit Kucheria 2020-04-29  831  	priv->rf[SENSOR_EN] = devm_regmap_field_alloc(dev, priv->srot_map,
a7ff82976122eb Amit Kucheria 2020-04-29  832  						      priv->fields[SENSOR_EN]);
a7ff82976122eb Amit Kucheria 2020-04-29  833  	if (IS_ERR(priv->rf[SENSOR_EN])) {
a7ff82976122eb Amit Kucheria 2020-04-29  834  		ret = PTR_ERR(priv->rf[SENSOR_EN]);
a7ff82976122eb Amit Kucheria 2020-04-29  835  		goto err_put_device;
a7ff82976122eb Amit Kucheria 2020-04-29  836  	}
a7ff82976122eb Amit Kucheria 2020-04-29  837  	priv->rf[INT_EN] = devm_regmap_field_alloc(dev, priv->tm_map,
a7ff82976122eb Amit Kucheria 2020-04-29  838  						   priv->fields[INT_EN]);
a7ff82976122eb Amit Kucheria 2020-04-29  839  	if (IS_ERR(priv->rf[INT_EN])) {
a7ff82976122eb Amit Kucheria 2020-04-29  840  		ret = PTR_ERR(priv->rf[INT_EN]);
a7ff82976122eb Amit Kucheria 2020-04-29  841  		goto err_put_device;
a7ff82976122eb Amit Kucheria 2020-04-29  842  	}
a7ff82976122eb Amit Kucheria 2020-04-29  843  
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  844  	priv->rf[TSENS_SW_RST] =
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  845  		devm_regmap_field_alloc(dev, priv->srot_map, priv->fields[TSENS_SW_RST]);
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  846  	if (IS_ERR(priv->rf[TSENS_SW_RST])) {
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  847  		ret = PTR_ERR(priv->rf[TSENS_SW_RST]);
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  848  		goto err_put_device;
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  849  	}
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  850  
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  851  	priv->rf[TRDY] = devm_regmap_field_alloc(dev, priv->tm_map, priv->fields[TRDY]);
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  852  	if (IS_ERR(priv->rf[TRDY])) {
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  853  		ret = PTR_ERR(priv->rf[TRDY]);
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  854  		goto err_put_device;
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  855  	}
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  856  
a7ff82976122eb Amit Kucheria 2020-04-29  857  	/* This loop might need changes if enum regfield_ids is reordered */
a7ff82976122eb Amit Kucheria 2020-04-29  858  	for (j = LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {
a7ff82976122eb Amit Kucheria 2020-04-29  859  		for (i = 0; i < priv->feat->max_sensors; i++) {
a7ff82976122eb Amit Kucheria 2020-04-29  860  			int idx = j + i;
a7ff82976122eb Amit Kucheria 2020-04-29  861  
a7ff82976122eb Amit Kucheria 2020-04-29  862  			priv->rf[idx] = devm_regmap_field_alloc(dev,
a7ff82976122eb Amit Kucheria 2020-04-29  863  								priv->tm_map,
a7ff82976122eb Amit Kucheria 2020-04-29  864  								priv->fields[idx]);
a7ff82976122eb Amit Kucheria 2020-04-29  865  			if (IS_ERR(priv->rf[idx])) {
a7ff82976122eb Amit Kucheria 2020-04-29  866  				ret = PTR_ERR(priv->rf[idx]);
a7ff82976122eb Amit Kucheria 2020-04-29  867  				goto err_put_device;
a7ff82976122eb Amit Kucheria 2020-04-29  868  			}
a7ff82976122eb Amit Kucheria 2020-04-29  869  		}
a7ff82976122eb Amit Kucheria 2020-04-29  870  	}
a7ff82976122eb Amit Kucheria 2020-04-29  871  
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  872  	if (priv->feat->crit_int || tsens_version(priv) < VER_0_1) {
a7ff82976122eb Amit Kucheria 2020-04-29  873  		/* Loop might need changes if enum regfield_ids is reordered */
a7ff82976122eb Amit Kucheria 2020-04-29  874  		for (j = CRITICAL_STATUS_0; j <= CRIT_THRESH_15; j += 16) {
a7ff82976122eb Amit Kucheria 2020-04-29  875  			for (i = 0; i < priv->feat->max_sensors; i++) {
a7ff82976122eb Amit Kucheria 2020-04-29  876  				int idx = j + i;
a7ff82976122eb Amit Kucheria 2020-04-29  877  
a7ff82976122eb Amit Kucheria 2020-04-29  878  				priv->rf[idx] =
a7ff82976122eb Amit Kucheria 2020-04-29  879  					devm_regmap_field_alloc(dev,
a7ff82976122eb Amit Kucheria 2020-04-29  880  								priv->tm_map,
a7ff82976122eb Amit Kucheria 2020-04-29  881  								priv->fields[idx]);
a7ff82976122eb Amit Kucheria 2020-04-29  882  				if (IS_ERR(priv->rf[idx])) {
a7ff82976122eb Amit Kucheria 2020-04-29  883  					ret = PTR_ERR(priv->rf[idx]);
a7ff82976122eb Amit Kucheria 2020-04-29  884  					goto err_put_device;
a7ff82976122eb Amit Kucheria 2020-04-29  885  				}
a7ff82976122eb Amit Kucheria 2020-04-29  886  			}
a7ff82976122eb Amit Kucheria 2020-04-29  887  		}
a7ff82976122eb Amit Kucheria 2020-04-29  888  	}
a7ff82976122eb Amit Kucheria 2020-04-29  889  
a7ff82976122eb Amit Kucheria 2020-04-29  890  	if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {
a7ff82976122eb Amit Kucheria 2020-04-29  891  		/* Watchdog is present only on v2.3+ */
a7ff82976122eb Amit Kucheria 2020-04-29  892  		priv->feat->has_watchdog = 1;
a7ff82976122eb Amit Kucheria 2020-04-29  893  		for (i = WDOG_BARK_STATUS; i <= CC_MON_MASK; i++) {
a7ff82976122eb Amit Kucheria 2020-04-29  894  			priv->rf[i] = devm_regmap_field_alloc(dev, priv->tm_map,
a7ff82976122eb Amit Kucheria 2020-04-29  895  							      priv->fields[i]);
a7ff82976122eb Amit Kucheria 2020-04-29  896  			if (IS_ERR(priv->rf[i])) {
a7ff82976122eb Amit Kucheria 2020-04-29  897  				ret = PTR_ERR(priv->rf[i]);
a7ff82976122eb Amit Kucheria 2020-04-29  898  				goto err_put_device;
a7ff82976122eb Amit Kucheria 2020-04-29  899  			}
a7ff82976122eb Amit Kucheria 2020-04-29  900  		}
a7ff82976122eb Amit Kucheria 2020-04-29  901  		/*
a7ff82976122eb Amit Kucheria 2020-04-29  902  		 * Watchdog is already enabled, unmask the bark.
a7ff82976122eb Amit Kucheria 2020-04-29  903  		 * Disable cycle completion monitoring
a7ff82976122eb Amit Kucheria 2020-04-29  904  		 */
a7ff82976122eb Amit Kucheria 2020-04-29  905  		regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
a7ff82976122eb Amit Kucheria 2020-04-29  906  		regmap_field_write(priv->rf[CC_MON_MASK], 1);
a7ff82976122eb Amit Kucheria 2020-04-29  907  	}
a7ff82976122eb Amit Kucheria 2020-04-29  908  
a7ff82976122eb Amit Kucheria 2020-04-29  909  	spin_lock_init(&priv->ul_lock);
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  910  
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  911  	/* VER_0 interrupt doesn't need to be enabled */
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  912  	if (tsens_version(priv) >= VER_0_1)
a7ff82976122eb Amit Kucheria 2020-04-29  913  		tsens_enable_irq(priv);
fea5c5e6f2e2a0 Ansuel Smith  2021-03-24  914  
a7ff82976122eb Amit Kucheria 2020-04-29  915  	tsens_debug_init(op);
a7ff82976122eb Amit Kucheria 2020-04-29  916  
a7ff82976122eb Amit Kucheria 2020-04-29  917  err_put_device:
a7ff82976122eb Amit Kucheria 2020-04-29  918  	put_device(&op->dev);
a7ff82976122eb Amit Kucheria 2020-04-29  919  	return ret;
a7ff82976122eb Amit Kucheria 2020-04-29  920  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 

--98e8jtXdkpgskNou
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
dE/MFsVhVQmj0kuCBE6KfwFyUdLZR2ICAA==

--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

--98e8jtXdkpgskNou--
