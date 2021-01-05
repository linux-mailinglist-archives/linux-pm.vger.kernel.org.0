Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECA92EA41F
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 04:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbhAEDwe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 22:52:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:14655 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbhAEDwe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Jan 2021 22:52:34 -0500
IronPort-SDR: oBppnDRgyPEu+EdIHUma0rFNWJQIr9D9TmliVIa/sHAi8CPRt1u+tSsio747m0fktooxgbUzA5
 Z7dKon2wx4kw==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156240879"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="gz'50?scan'50,208,50";a="156240879"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 19:51:52 -0800
IronPort-SDR: DaL5H0cdKILv6llph134jFhgGOlpIYhpnGtB98TX0r23B506chDe1/4v7caYJNQ9mMr8iJCE3z
 zPMiu0lh7HLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="gz'50?scan'50,208,50";a="386833176"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Jan 2021 19:51:49 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kwdNt-0007tA-6X; Tue, 05 Jan 2021 03:51:49 +0000
Date:   Tue, 5 Jan 2021 11:50:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>, sre@kernel.org,
        robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        dmurphy@ti.com, Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: Re: [PATCH v8 2/2] power: supply: bq256xx: Introduce the BQ256XX
 charger driver
Message-ID: <202101051111.3csiSfkT-lkp@intel.com>
References: <20210104202450.9669-3-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20210104202450.9669-3-r-rivera-matos@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ricardo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on power-supply/for-next]
[also build test WARNING on robh/for-next v5.11-rc2 next-20210104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ricardo-Rivera-Matos/Introduce-the-BQ256XX-family-of-chargers/20210105-043028
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
config: s390-randconfig-r005-20210105 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 5c951623bc8965fa1e89660f2f5f4a2944e4981a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/0day-ci/linux/commit/82436c2c6d99c4effb187bbd09b47c4dc59a1f3d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Ricardo-Rivera-Matos/Introduce-the-BQ256XX-family-of-chargers/20210105-043028
        git checkout 82436c2c6d99c4effb187bbd09b47c4dc59a1f3d
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   include/uapi/linux/swab.h:19:12: note: expanded from macro '___constant_swab32'
           (((__u32)(x) & (__u32)0x000000ffUL) << 24) |            \
                     ^
   In file included from drivers/power/supply/bq256xx_charger.c:13:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:80:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:119:21: note: expanded from macro '__swab32'
           ___constant_swab32(x) :                 \
                              ^
   include/uapi/linux/swab.h:20:12: note: expanded from macro '___constant_swab32'
           (((__u32)(x) & (__u32)0x0000ff00UL) <<  8) |            \
                     ^
   In file included from drivers/power/supply/bq256xx_charger.c:13:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:80:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:119:21: note: expanded from macro '__swab32'
           ___constant_swab32(x) :                 \
                              ^
   include/uapi/linux/swab.h:21:12: note: expanded from macro '___constant_swab32'
           (((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |            \
                     ^
   In file included from drivers/power/supply/bq256xx_charger.c:13:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:80:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:119:21: note: expanded from macro '__swab32'
           ___constant_swab32(x) :                 \
                              ^
   include/uapi/linux/swab.h:22:12: note: expanded from macro '___constant_swab32'
           (((__u32)(x) & (__u32)0xff000000UL) >> 24)))
                     ^
   In file included from drivers/power/supply/bq256xx_charger.c:13:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:80:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:120:12: note: expanded from macro '__swab32'
           __fswab32(x))
                     ^
   In file included from drivers/power/supply/bq256xx_charger.c:13:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:80:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/power/supply/bq256xx_charger.c:1644:29: warning: variable 'psy_cfg' is uninitialized when used here [-Wuninitialized]
           ret = bq256xx_parse_dt(bq, psy_cfg, dev);
                                      ^~~~~~~
   drivers/power/supply/bq256xx_charger.c:1618:37: note: initialize the variable 'psy_cfg' to silence this warning
           struct power_supply_config *psy_cfg;
                                              ^
                                               = NULL
>> drivers/power/supply/bq256xx_charger.c:1720:36: warning: unused variable 'bq256xx_acpi_match' [-Wunused-const-variable]
   static const struct acpi_device_id bq256xx_acpi_match[] = {
                                      ^
   22 warnings generated.


vim +/psy_cfg +1644 drivers/power/supply/bq256xx_charger.c

  1612	
  1613	static int bq256xx_probe(struct i2c_client *client,
  1614				 const struct i2c_device_id *id)
  1615	{
  1616		struct device *dev = &client->dev;
  1617		struct bq256xx_device *bq;
  1618		struct power_supply_config *psy_cfg;
  1619	
  1620		int ret;
  1621	
  1622		bq = devm_kzalloc(dev, sizeof(*bq), GFP_KERNEL);
  1623		if (!bq)
  1624			return -ENOMEM;
  1625	
  1626		bq->client = client;
  1627		bq->dev = dev;
  1628		bq->chip_info = &bq256xx_chip_info_tbl[id->driver_data];
  1629	
  1630		mutex_init(&bq->lock);
  1631	
  1632		strncpy(bq->model_name, id->name, I2C_NAME_SIZE);
  1633	
  1634		bq->regmap = devm_regmap_init_i2c(client,
  1635						bq->chip_info->bq256xx_regmap_config);
  1636	
  1637		if (IS_ERR(bq->regmap)) {
  1638			dev_err(dev, "Failed to allocate register map\n");
  1639			return PTR_ERR(bq->regmap);
  1640		}
  1641	
  1642		i2c_set_clientdata(client, bq);
  1643	
> 1644		ret = bq256xx_parse_dt(bq, psy_cfg, dev);
  1645		if (ret) {
  1646			dev_err(dev, "Failed to read device tree properties%d\n", ret);
  1647			return ret;
  1648		}
  1649	
  1650		ret = devm_add_action_or_reset(dev, bq256xx_charger_reset, bq);
  1651		if (ret)
  1652			return ret;
  1653	
  1654		/* OTG reporting */
  1655		bq->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
  1656		if (!IS_ERR_OR_NULL(bq->usb2_phy)) {
  1657			INIT_WORK(&bq->usb_work, bq256xx_usb_work);
  1658			bq->usb_nb.notifier_call = bq256xx_usb_notifier;
  1659			usb_register_notifier(bq->usb2_phy, &bq->usb_nb);
  1660		}
  1661	
  1662		bq->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
  1663		if (!IS_ERR_OR_NULL(bq->usb3_phy)) {
  1664			INIT_WORK(&bq->usb_work, bq256xx_usb_work);
  1665			bq->usb_nb.notifier_call = bq256xx_usb_notifier;
  1666			usb_register_notifier(bq->usb3_phy, &bq->usb_nb);
  1667		}
  1668	
  1669		if (client->irq) {
  1670			ret = devm_request_threaded_irq(dev, client->irq, NULL,
  1671							bq256xx_irq_handler_thread,
  1672							IRQF_TRIGGER_FALLING |
  1673							IRQF_ONESHOT,
  1674							dev_name(&client->dev), bq);
  1675			if (ret < 0) {
  1676				dev_err(dev, "get irq fail: %d\n", ret);
  1677				return ret;
  1678			}
  1679		}
  1680	
  1681		ret = bq256xx_power_supply_init(bq, psy_cfg, dev);
  1682		if (ret) {
  1683			dev_err(dev, "Failed to register power supply\n");
  1684			return ret;
  1685		}
  1686	
  1687		ret = bq256xx_hw_init(bq);
  1688		if (ret) {
  1689			dev_err(dev, "Cannot initialize the chip.\n");
  1690			return ret;
  1691		}
  1692	
  1693		return ret;
  1694	}
  1695	
  1696	static const struct i2c_device_id bq256xx_i2c_ids[] = {
  1697		{ "bq25600", BQ25600 },
  1698		{ "bq25600d", BQ25600D },
  1699		{ "bq25601", BQ25601 },
  1700		{ "bq25601d", BQ25601D },
  1701		{ "bq25611d", BQ25611D },
  1702		{ "bq25618", BQ25618 },
  1703		{ "bq25619", BQ25619 },
  1704		{},
  1705	};
  1706	MODULE_DEVICE_TABLE(i2c, bq256xx_i2c_ids);
  1707	
  1708	static const struct of_device_id bq256xx_of_match[] = {
  1709		{ .compatible = "ti,bq25600", .data = (void *)BQ25600 },
  1710		{ .compatible = "ti,bq25600d", .data = (void *)BQ25600D },
  1711		{ .compatible = "ti,bq25601", .data = (void *)BQ25601 },
  1712		{ .compatible = "ti,bq25601d", .data = (void *)BQ25601D },
  1713		{ .compatible = "ti,bq25611d", .data = (void *)BQ25611D },
  1714		{ .compatible = "ti,bq25618", .data = (void *)BQ25618 },
  1715		{ .compatible = "ti,bq25619", .data = (void *)BQ25619 },
  1716		{ },
  1717	};
  1718	MODULE_DEVICE_TABLE(of, bq256xx_of_match);
  1719	
> 1720	static const struct acpi_device_id bq256xx_acpi_match[] = {
  1721		{ "bq25600", BQ25600 },
  1722		{ "bq25600d", BQ25600D },
  1723		{ "bq25601", BQ25601 },
  1724		{ "bq25601d", BQ25601D },
  1725		{ "bq25611d", BQ25611D },
  1726		{ "bq25618", BQ25618 },
  1727		{ "bq25619", BQ25619 },
  1728		{},
  1729	};
  1730	MODULE_DEVICE_TABLE(acpi, bq256xx_acpi_match);
  1731	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--RnlQjJ0d97Da+TV1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
zJLXxdwxyuwyC8Wm84tUFfaw/AesdrDMcMMAAA==

--RnlQjJ0d97Da+TV1--
