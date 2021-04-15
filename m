Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6481A361377
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 22:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbhDOU2T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 16:28:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:37944 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234506AbhDOU2S (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Apr 2021 16:28:18 -0400
IronPort-SDR: 8HMZmTzwxl8QbRcGaNGLdnMd69BkDpSE3Az4VJPHihmKw7LTRXvr/nBH0d2oqXhpIwHWyxcfrf
 I0oSRC9TXgbA==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="256251185"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="gz'50?scan'50,208,50";a="256251185"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 13:27:54 -0700
IronPort-SDR: 5OYNlxRrM38+Urey0A3KG+BT6lHl8boN5szdDJe9A0DGMphgR10vqdjgPGspXwBWut0bZsO+bo
 qqf29k/d2p7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="gz'50?scan'50,208,50";a="601252583"
Received: from lkp-server02.sh.intel.com (HELO fa9c8fcc3464) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Apr 2021 13:27:50 -0700
Received: from kbuild by fa9c8fcc3464 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lX8ac-00014P-0J; Thu, 15 Apr 2021 20:27:50 +0000
Date:   Fri, 16 Apr 2021 04:27:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     thermal-bot for Ansuel Smith <tip-bot2@linutronix.de>,
        linux-pm@vger.kernel.org
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
Subject: Re: [thermal: thermal/next] thermal/drivers/tsens: Convert msm8960
 to reg_field
Message-ID: <202104160443.FvPdV3ZA-lkp@intel.com>
References: <161848823868.29796.2378720492280917598.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <161848823868.29796.2378720492280917598.tip-bot2@tip-bot2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi thermal-bot,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.12-rc7]
[cannot apply to thermal/next next-20210415]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/thermal-bot-for-Ansuel-Smith/thermal-drivers-tsens-Convert-msm8960-to-reg_field/20210415-200542
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7f75285ca572eaabc028cf78c6ab5473d0d160be
config: powerpc-randconfig-r022-20210415 (attached as .config)
compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 6a18cc23efad410db48a3ccfc233d215de7d4cb9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/0day-ci/linux/commit/efea0f0570b6b581bdb2fad978a35fd1a521385b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review thermal-bot-for-Ansuel-Smith/thermal-drivers-tsens-Convert-msm8960-to-reg_field/20210415-200542
        git checkout efea0f0570b6b581bdb2fad978a35fd1a521385b
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/thermal/qcom/tsens-8960.c:193:29: error: use of undeclared identifier 'S0_STATUS_ADDR'
                           priv->sensor[i].status = S0_STATUS_ADDR + 40;
                                                    ^
>> drivers/thermal/qcom/tsens-8960.c:284:15: error: use of undeclared identifier 'VER_0'
           .ver_major      = VER_0,
                             ^
   2 errors generated.


vim +/S0_STATUS_ADDR +193 drivers/thermal/qcom/tsens-8960.c

20d4fd84bf524ad Rajendra Nayak               2016-05-05  175  
69b628ac71f07d6 Amit Kucheria                2019-03-20  176  static int init_8960(struct tsens_priv *priv)
20d4fd84bf524ad Rajendra Nayak               2016-05-05  177  {
20d4fd84bf524ad Rajendra Nayak               2016-05-05  178  	int ret, i;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  179  	u32 reg_cntl;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  180  
69b628ac71f07d6 Amit Kucheria                2019-03-20  181  	priv->tm_map = dev_get_regmap(priv->dev, NULL);
69b628ac71f07d6 Amit Kucheria                2019-03-20  182  	if (!priv->tm_map)
20d4fd84bf524ad Rajendra Nayak               2016-05-05  183  		return -ENODEV;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  184  
20d4fd84bf524ad Rajendra Nayak               2016-05-05  185  	/*
20d4fd84bf524ad Rajendra Nayak               2016-05-05  186  	 * The status registers for each sensor are discontiguous
20d4fd84bf524ad Rajendra Nayak               2016-05-05  187  	 * because some SoCs have 5 sensors while others have more
20d4fd84bf524ad Rajendra Nayak               2016-05-05  188  	 * but the control registers stay in the same place, i.e
20d4fd84bf524ad Rajendra Nayak               2016-05-05  189  	 * directly after the first 5 status registers.
20d4fd84bf524ad Rajendra Nayak               2016-05-05  190  	 */
69b628ac71f07d6 Amit Kucheria                2019-03-20  191  	for (i = 0; i < priv->num_sensors; i++) {
20d4fd84bf524ad Rajendra Nayak               2016-05-05  192  		if (i >= 5)
69b628ac71f07d6 Amit Kucheria                2019-03-20 @193  			priv->sensor[i].status = S0_STATUS_ADDR + 40;
69b628ac71f07d6 Amit Kucheria                2019-03-20  194  		priv->sensor[i].status += i * 4;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  195  	}
20d4fd84bf524ad Rajendra Nayak               2016-05-05  196  
20d4fd84bf524ad Rajendra Nayak               2016-05-05  197  	reg_cntl = SW_RST;
69b628ac71f07d6 Amit Kucheria                2019-03-20  198  	ret = regmap_update_bits(priv->tm_map, CNTL_ADDR, SW_RST, reg_cntl);
20d4fd84bf524ad Rajendra Nayak               2016-05-05  199  	if (ret)
20d4fd84bf524ad Rajendra Nayak               2016-05-05  200  		return ret;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  201  
69b628ac71f07d6 Amit Kucheria                2019-03-20  202  	if (priv->num_sensors > 1) {
20d4fd84bf524ad Rajendra Nayak               2016-05-05  203  		reg_cntl |= SLP_CLK_ENA | (MEASURE_PERIOD << 18);
20d4fd84bf524ad Rajendra Nayak               2016-05-05  204  		reg_cntl &= ~SW_RST;
69b628ac71f07d6 Amit Kucheria                2019-03-20  205  		ret = regmap_update_bits(priv->tm_map, CONFIG_ADDR,
20d4fd84bf524ad Rajendra Nayak               2016-05-05  206  					 CONFIG_MASK, CONFIG);
20d4fd84bf524ad Rajendra Nayak               2016-05-05  207  	} else {
20d4fd84bf524ad Rajendra Nayak               2016-05-05  208  		reg_cntl |= SLP_CLK_ENA_8660 | (MEASURE_PERIOD << 16);
20d4fd84bf524ad Rajendra Nayak               2016-05-05  209  		reg_cntl &= ~CONFIG_MASK_8660;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  210  		reg_cntl |= CONFIG_8660 << CONFIG_SHIFT_8660;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  211  	}
20d4fd84bf524ad Rajendra Nayak               2016-05-05  212  
69b628ac71f07d6 Amit Kucheria                2019-03-20  213  	reg_cntl |= GENMASK(priv->num_sensors - 1, 0) << SENSOR0_SHIFT;
69b628ac71f07d6 Amit Kucheria                2019-03-20  214  	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
20d4fd84bf524ad Rajendra Nayak               2016-05-05  215  	if (ret)
20d4fd84bf524ad Rajendra Nayak               2016-05-05  216  		return ret;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  217  
20d4fd84bf524ad Rajendra Nayak               2016-05-05  218  	reg_cntl |= EN;
69b628ac71f07d6 Amit Kucheria                2019-03-20  219  	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
20d4fd84bf524ad Rajendra Nayak               2016-05-05  220  	if (ret)
20d4fd84bf524ad Rajendra Nayak               2016-05-05  221  		return ret;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  222  
20d4fd84bf524ad Rajendra Nayak               2016-05-05  223  	return 0;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  224  }
20d4fd84bf524ad Rajendra Nayak               2016-05-05  225  
69b628ac71f07d6 Amit Kucheria                2019-03-20  226  static int calibrate_8960(struct tsens_priv *priv)
20d4fd84bf524ad Rajendra Nayak               2016-05-05  227  {
20d4fd84bf524ad Rajendra Nayak               2016-05-05  228  	int i;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  229  	char *data;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  230  
69b628ac71f07d6 Amit Kucheria                2019-03-20  231  	ssize_t num_read = priv->num_sensors;
69b628ac71f07d6 Amit Kucheria                2019-03-20  232  	struct tsens_sensor *s = priv->sensor;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  233  
69b628ac71f07d6 Amit Kucheria                2019-03-20  234  	data = qfprom_read(priv->dev, "calib");
20d4fd84bf524ad Rajendra Nayak               2016-05-05  235  	if (IS_ERR(data))
69b628ac71f07d6 Amit Kucheria                2019-03-20  236  		data = qfprom_read(priv->dev, "calib_backup");
20d4fd84bf524ad Rajendra Nayak               2016-05-05  237  	if (IS_ERR(data))
20d4fd84bf524ad Rajendra Nayak               2016-05-05  238  		return PTR_ERR(data);
20d4fd84bf524ad Rajendra Nayak               2016-05-05  239  
20d4fd84bf524ad Rajendra Nayak               2016-05-05  240  	for (i = 0; i < num_read; i++, s++)
20d4fd84bf524ad Rajendra Nayak               2016-05-05  241  		s->offset = data[i];
20d4fd84bf524ad Rajendra Nayak               2016-05-05  242  
6b8249abb093551 Srinivas Kandagatla          2019-08-23  243  	kfree(data);
6b8249abb093551 Srinivas Kandagatla          2019-08-23  244  
20d4fd84bf524ad Rajendra Nayak               2016-05-05  245  	return 0;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  246  }
20d4fd84bf524ad Rajendra Nayak               2016-05-05  247  
20d4fd84bf524ad Rajendra Nayak               2016-05-05  248  /* Temperature on y axis and ADC-code on x-axis */
20d4fd84bf524ad Rajendra Nayak               2016-05-05  249  static inline int code_to_mdegC(u32 adc_code, const struct tsens_sensor *s)
20d4fd84bf524ad Rajendra Nayak               2016-05-05  250  {
20d4fd84bf524ad Rajendra Nayak               2016-05-05  251  	int slope, offset;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  252  
20d4fd84bf524ad Rajendra Nayak               2016-05-05  253  	slope = thermal_zone_get_slope(s->tzd);
20d4fd84bf524ad Rajendra Nayak               2016-05-05  254  	offset = CAL_MDEGC - slope * s->offset;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  255  
20d4fd84bf524ad Rajendra Nayak               2016-05-05  256  	return adc_code * slope + offset;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  257  }
20d4fd84bf524ad Rajendra Nayak               2016-05-05  258  
e604bdd2a7e1087 Amit Kucheria                2020-03-12  259  static int get_temp_8960(const struct tsens_sensor *s, int *temp)
20d4fd84bf524ad Rajendra Nayak               2016-05-05  260  {
20d4fd84bf524ad Rajendra Nayak               2016-05-05  261  	int ret;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  262  	u32 code, trdy;
8b71bce407b3f13 Amit Kucheria                2019-11-01  263  	struct tsens_priv *priv = s->priv;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  264  	unsigned long timeout;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  265  
20d4fd84bf524ad Rajendra Nayak               2016-05-05  266  	timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
20d4fd84bf524ad Rajendra Nayak               2016-05-05  267  	do {
69b628ac71f07d6 Amit Kucheria                2019-03-20  268  		ret = regmap_read(priv->tm_map, INT_STATUS_ADDR, &trdy);
20d4fd84bf524ad Rajendra Nayak               2016-05-05  269  		if (ret)
20d4fd84bf524ad Rajendra Nayak               2016-05-05  270  			return ret;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  271  		if (!(trdy & TRDY_MASK))
20d4fd84bf524ad Rajendra Nayak               2016-05-05  272  			continue;
69b628ac71f07d6 Amit Kucheria                2019-03-20  273  		ret = regmap_read(priv->tm_map, s->status, &code);
20d4fd84bf524ad Rajendra Nayak               2016-05-05  274  		if (ret)
20d4fd84bf524ad Rajendra Nayak               2016-05-05  275  			return ret;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  276  		*temp = code_to_mdegC(code, s);
20d4fd84bf524ad Rajendra Nayak               2016-05-05  277  		return 0;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  278  	} while (time_before(jiffies, timeout));
20d4fd84bf524ad Rajendra Nayak               2016-05-05  279  
20d4fd84bf524ad Rajendra Nayak               2016-05-05  280  	return -ETIMEDOUT;
20d4fd84bf524ad Rajendra Nayak               2016-05-05  281  }
20d4fd84bf524ad Rajendra Nayak               2016-05-05  282  
efea0f0570b6b58 thermal-bot for Ansuel Smith 2021-04-15  283  static struct tsens_features tsens_8960_feat = {
efea0f0570b6b58 thermal-bot for Ansuel Smith 2021-04-15 @284  	.ver_major	= VER_0,
efea0f0570b6b58 thermal-bot for Ansuel Smith 2021-04-15  285  	.crit_int	= 0,
efea0f0570b6b58 thermal-bot for Ansuel Smith 2021-04-15  286  	.adc		= 1,
efea0f0570b6b58 thermal-bot for Ansuel Smith 2021-04-15  287  	.srot_split	= 0,
efea0f0570b6b58 thermal-bot for Ansuel Smith 2021-04-15  288  	.max_sensors	= 11,
efea0f0570b6b58 thermal-bot for Ansuel Smith 2021-04-15  289  };
efea0f0570b6b58 thermal-bot for Ansuel Smith 2021-04-15  290  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--HcAYCG3uE/tztfnV
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICLKceGAAAy5jb25maWcAjDzLdtu4kvv+Cp305s6iO5ZfSWaOFxAISmiRBA2QkuwNjiIz
ac+1rYws5yZ/P1XgCwBBpXuRjqoKhVe9Uczvv/0+IW/H/fP2+LjbPj39nHytXqrD9lg9TL48
PlX/M4nEJBPFhEW8+BOIk8eXtx/vv+3/Ux2+7SZXf07P/zz747D7MFlWh5fqaUL3L18ev74B
h8f9y2+//0ZFFvO5plSvmFRcZLpgm+Lm3e5p+/J18r06vALdZHrx59mfZ5N/fX08/vf79/Dn
8+PhsD+8f3r6/qy/Hfb/W+2Ok+vt9ONud35Rfdk+XE7PHj5fftxe7HZfAHTxcD69eqg+PFzu
Pn/6r3ftrPN+2pszaylcaZqQbH7zswPiz452enEG/7W4JBoyARgwSZKoZ5FYdC4DmHFBlCYq
1XNRCGtWF6FFWeRlEcTzLOEZ61Fc3uq1kMseMit5EhU8Zbogs4RpJaTFqlhIRmDRWSzgDyBR
OBQu6PfJ3Nz40+S1Or59669sJsWSZRpuTKW5NXHGC82ylSYS9sxTXtxcnHcLFmnOYe6CKWvu
RFCStEfz7p2zYK1IUljABVkxvWQyY4me33NrYhuzue/hLvHvExe8uZ88vk5e9kfcXjskYjEp
k8LsxZq7BS+EKjKSspt3/3rZv1QgTx1XtSa5zbBH3KkVz2lgslwovtHpbclK6/7WpKAL3QI7
NlQKpXTKUiHvNCkKQhcBlqViCZ/Z40gJ+hmgNIdGJExlKGCVcBVJe/MgRJPXt8+vP1+P1XN/
83OWMcmpkTG1EOt+1T5GJ2zFkjCeZ38xWuCVB9F0YV8uQiKREp65MMXTEJFecCZxW3cuNiaq
YIL3aDiALEpA9IaLSBXHMaOI4HpiISmLGm3itgVROZGKhTkabmxWzmNlLq16eZjsv3jH7w8y
qrzqb8xDU9CqJZx+VgT2RlOhdJlHpGDtXRePz2BsQ9ddcLoENWdwoZbSLu51DrxExKktaJlA
DIczDaqBQYfkkM8XWjJldiWdUxgsrFMcyViaF8Azc3Skha9EUmYFkXfBlTRUIYVsxlMBw9vj
oXn5vti+/ntyhOVMtrC01+P2+DrZ7nb7t5fj48tX78BggCbU8KjloJt5xWXhoXVGCr5igcWg
aJibdni1K1Xc+dFZqIgrtPGRfY7/YAeWnYHlcSUSggpqL8schqTlRIUEJbvTgLM3Cz8124Ck
hE5a1cT2cA8EbkgZHo3kBlADUBmxELyQhLJuec2huDvpDn1Z/+Xmud8IXy5ApUE2A/tIBHqr
GEwej4ub6YdeknhWLMGFxcynuahPUu3+rh7enqrD5Eu1Pb4dqlcDblYXwFpXNJeizEPLoQtG
l7mAuVGlCiEd9VCAjsDcF8IwGPNWsQJpAlWgYCOiwCSSJcSyrrNkCfQr4zKlFfWY3yQFbkqU
YBstdyojz4MDYAaAcweS3KfEEago7LMNqfCGXnoj71UR2stMCFR3c+W2s6Va5KB8/J6hYUd7
B/9LSUZDmupTK/iLF51AOBNhlEUFiCgYX6IZRkgZcd3gPycTMgcHBsGCtODoEooEtI6yvDAR
NUq+dVV53P+oddPedQoGhEMEIUMKO2dFCtqkB26nlpgBOK79q2OeTbxT2/mg9UWdscxarUNZ
apk68JTWDwJuNS6dWUtIIryfOuf2KlgukiS0Qz7PSBJHNq1ZaxwFNcV42BGcWkCgFpiDcGGz
50KXsMl5iDJacdhdc6yWIwfGMyIlhDFWoIskd6kaQrRzJx3UnBzqMfoee0UgIe2cwY2hdBhH
E4e0yYSTmJf0i9TIakbo0lpciEzdZRCc1AarXS21swsIoaz4ycRMHgyYsShikad6qLu6C4d6
YaTTs8uBf2ty1bw6fNkfnrcvu2rCvlcv4CwJGGaK7hJCkt7x+cwb8/0P2bRcVmnNow48nJgU
8yZSQMq1dCx5QmZhwUvKWUi2EzGzNBZGw9nLOWvDBgu3KOMY8rScABauDhI0cCOOthcsrW0T
JG485tQzTrkUMU+caMWYIeOWnFNy08tufE4vzp2byun18Kbyw35Xvb7uDxAffvu2PxzrYK0b
gqZ9eaH0xXk4CASKj1c/fowjR3CXZz8CB3x5+SMQa+dWKII8Y4itJJurAbQHXP6wGOEWLIXI
C6avL2fcuq58cacGMOCZpiVEx6BjizG4vrC8bQ5gY8d7UGYc44JJI5eQbTL76oan38lypITN
GuPJGWpnFnFiicnFubNoWJhnINKU5FpmEBlAdqpTsrmZXp0igITsUxjf6tCv+Dh0NrtMYjSu
bq6mXT1DQQK+rANLVea5W1ExYBgRJ2SuhnjMzyDCGiJawVmsGWRF7pVado7I5G7oLUnWpIai
hCjzY1djqqM+kfJCxxCPgWqjItruoz4FctfYS5DIiLpiU0azuZ5eX12dWaOwbGDGDjfguGkL
2PmcdhEDr8BnTNbhDoYLis8S5pGoUuUgTAE0rjSiskmpBvABH3P6mA1LMWOeUoL/bZ3MQGF7
HCdU3VyGcRHizkdwqxM4QrUk2dzewLwu3JmaijsQ7AXcGMdoDiJ+d6GIS51EMa9rGCDhIPNt
gps/bY/opixD2omOSJ3yhMXn8kPIDs5ICkbLTg5KzEPs+iSbicxKHxRJLy/PmOXpwamXghM7
i+NqYWxHX8MjsAMeNNCSQOYRjGEhWM5dIbBvnZLsTmQJRK3OXucJoR67fioWrYUIRUKgv0bD
OtI7oRioYLg2wpW6/BE6Tk4dzwpXevkDK1+5J/Z40/OcWwfvnan5uXF+z1303MWqvLJ+X5/Z
UTX8VNZPkqcfz6e23+Kz+k41k/LS8gVLCHTmpVMBZjnJIb8ikmBxxKq5TOJD9X9v1cvu5+R1
t31yyizoU2Jpx34tRM/FCqujEFCyYgQNQp0KR5o6NFj1InhDHUVbZ0FGI1nhLwaJNZg9Eiz5
BAdgyK3yOo87zVpkEYPVhFOS4AjAAffVWAnKOTZrt3Z1xKX5J5vzNxXCt1uBmcJX2K/blpkv
vsxMHg6P352IHcjqY3DFo4HpHPxTxFY97lZIfttSeFW1gIy2S+EPT1UzOYC6BSLYlWMeJd4h
IMTsMiGQzsgRZMqy0peIDlkwMSoEHdGCJIWfC9cOAW8xp92CJ1F3iH0AOEpjn0+9XQtiH0t3
wsyzXSLWsrAiEAggGkA/ve+z7Oxt/w2fGK07xxoz5Jr2cS3u9fTsLFSPvtfnJsyxSS9cUo9L
mM0NsHFjsIXE+rAV85JiAVlrmbQZVF+JcTCmxhGYw6NarHWZGd8AslHYebCJd1hmYojmBWkh
ijyxo7QwjYS/2aHUkm2YU/WHgA5TRBwWljiJuUZUpvlYvQCC5AImbOa2nEiSsDlJ2khRrwjE
EjdnXhSyNJlqsJwE6Ol1g/ejl+vQQIfi/Or6NG+TITc13S4EbB5Tu1JvAzbpsk9rXowwIdH3
ECAJibrepRw0jcyzbl80ZRvIKyAWgrQd0uge3sTDVvzUBMhgsNi9G4W0KLXkuSm5hPaWapUw
5jyZAgzLxgYePrEUoqslysIyeF6px80EleHJaWJnNWmXPtSPbs5Nrm9rj6NZHHOI0iBTbbxb
mLXHqtvnOIWIA2Wd1r50kqqIjlICgRBvndHs7XVohrpHv5rejcs55MeS0QKj+UFsR3PrsRMB
Slj2MVaJTmaOfbTn7zP6DOMbWED9At6ulTx8xwrVg//MDykJOvvIFLeFe/KJWKPOYqUbqxQh
62SR3Jz9MG0PVudDdJeRFJ9UWQqLcuvQRrNEHEMIN8bcIgHmu5a5/8ZvWI/xsGlsJu0UizvF
KekJzjyCwpTD2xOw05UG7q6suRnvtN3HwZIk/D788tYWy7aH3d+Px2qHj0J/PFTfgG31chwK
W214vYoqWm8f5me/f4GthtBjZgSktxyt5NyB2rAkxj6Osa6CXhvLDDY0z/DViVInPTWmH6JA
0+tR8EzPsIHCWpZkhb8yw5zD6rFgA8jCQw22UkPHODXk2McSew8lBh+XmelSwCxGyFDXgiFz
3if6rgrDcSGEZcxa/VdwwCYKq72FXwIhCl1DweO79uXMJTCVMxR+7R8AtgOlImoaavz9YiFD
E7T+WLtqbqQxWg6dU1Xva+huIaSHYyzf8EQ/HzoMR6ba6CUt9RwiGBhcVzfQXwXR+Ar8C5La
GTvvbmbiNQEpxNqdOS8C9wdJAzjddHDo9U3WL7Y0zTd04QdHa0aWGO8wfDwh9LbkMjydCQ6w
5aPtbAqciGIUy40nUDoGxfDcd40JGdtCtN0QNr9Aw4GvTqe6DAwFCFSzrpxRrPdbFyCiMgEN
Qj0Gm2CqewH+bIPymtVtOygnHo0ScYE4IBHrzCfplMLMAPIr0uH76rAg7Jc3Hdyn4eBsJUkK
rs6uCCVwohofr9ZERhZCYHcanw8irwZOPDPR1JVrvcXD9tZW+1fwNI1HkutNYPuqANtRuDSW
efaQp17nzKMBCEzkvq9j8Ga/Q4UCuV7Kx96g3dpqXdJE7TRvSW3IMadi9cfn7Su4wX/XMdW3
w/7LY1Pl6WtvQNbs6dR+DFn97MSaB8/+jenUTP5D1C98azsx6FSKD8u2RzEvqirF2c9c9UCJ
0KZyUgw0xwc0OUEibK/QoMqsAfdZoj2mRoeyxJBDGHoKn6uStO3LJeHss9tdaHSb35wc2F3W
EKMWZBrMNFya8/PL0zMgzdX1+CQXHy//wTRX0/PT05iXtnevf29hsncDLmgAsDo/zgO1Y61T
rlTdE5YyUx3TkM6jHg1NLmTmKCdiWVo+ZIYqbP+EOJQqDnb51q26tj07MzUPAuseUg+Oafhc
8iLY+9OgdDE9G6Ixv41ccJPf1o5Surj1rBgAdHrr80XLYr9Y2tBuyr6zAQ/DJDMk3NqABHUv
tWYZlXd5MAzPt4fjI5qDSfHzW2V3AkCSwE242OZNlrZByJ31FPayPJSmZUoyErJ2HiFjSmxG
p9CcqnEkidz3HB9vkuqC0eA5+cSSK8o3YVK+6QkDexIqHjmVFLzoyaEEkjLuDG4VhNAwz1RF
QoV59i4wSn9Boeb8FxRlAr54ZN9WISb7BcWSgMc4eQQsDh4A9ptffwyfgaV1oanb4qon47aC
pbdugaKBYaDJhQs2NYu6m1z0DY2WysA4LurSKHa9NZ8x9BfWo5d3s5EnuJZiFt8G9+JO3bu/
bNovtswavVc5JKLoSAfxZxfQkEJg2UKm65thiJZhBAteMyF5jnacRBGafe29dPSFOXM67Ee1
eztuPz9V5sOaiWkZOlrnNONZnBYY//Y84Af12jsbMkUlz8OvWA0FuJmwaiNHv1TbneTYMs0e
0up5f/g5Sbcv26/Vc7Ag0dR5rWMAABxZZOrNOiV+MoQt+3peek+2EA+y3HSOudfU1Ky71mVL
IfIE4u68MPEtJEPWi30zaIbu19WUBlTH7nREA3ukVbHDTFQylBYnlwKLJomfF0C+NddtZNwy
wOgcJUcXXWdPvywIzINBlcn0IKaflXYXoLKOu333M5lQyjMzx83l2afrrkDIQJFy7NmDjHHp
lGwpZL2Z6QIKHYNdy4QftRd27Q5p+wjC4+FqIa2++dAPuc/DVbv7WWm9Ct6bkBuObwAxFath
7aVunmmKSPYSTUHGXB5WbpZeV2Zfm2QSTweZh98OQGD1SHGsT8AKVmfTxG7OxHsxH0TZ+cu4
YvW31j2bZ9XxP/vDv/Hds1c/q6xKlyy0LrB/m/4A8RcYkdSxjxsdceJ2xWcsbGQAjp+fYbEi
JXJ5kgZk3STEcJxpPnbkQFyXQsIxRhFqtFVF3u9oJnk0Z/5vvUogea05O5raoFPpyEcDpXFo
OsPq49n59NY+oh6q5ysZfjixaNIxmojRLHhxSWLZDfhx3u8R4iP7HQWjcHBKCXPBPI8iVwsQ
gPEvCVWZNudX1nwkn/Xz5QtRC2LPijGGG7sKZWhAWz+KtqJ7+1a9VSC47xtv7fR7NNSazm77
GVvgopjZh96B4xEn1xLkkovxldXN8IHpwEMOgSq28qUeeDsEFuw2CS23mMUnFkNnasgK1GK4
koLgvux7aDFzycKdIS1BpHx99Qjg/+C/B1NGUg6B6e3YOtRy9oujpwtsex2wvI0D14FfSiTD
s4lvG0zgqClZhrxYPzS06sUiPi1N/BRP89Q+WDtzO9K78xw+YdZm/Gn7+vr45XHnfUGN42gy
YAUgrErxcS1AioLyLGKhcmFLEa/dlSOsdDp8a4B5DHBjhhp+QqqQRKpV7l5gC70eguNEBJaD
37UMgEjKpC8AiEnxC9uxLxyQiBmKk+cGYd8pGeKxlQxF1LIOUabw2yyBnz3bi5thR6MpHoT8
i8JPOl1xaWHGM4d9S0sBkWyOZeyRuJGLfoLnEUTbNWcfM+RMy0FckOZJKMbDk8nUwqZcqFCT
5q0sLHOCv7RKI3ucgRVlKCA3qHTBXWmQGwyL7zQ2O1lu/tb+kcf6L+4HUpNj9Xpsa9JNQDZA
eQg7+LL2SlJJoqDVo3ZXPPzQkqxdwMwOxhAw9wj+mn66+OQ05QEQMqEiHxoRkk2i6vvjzu7q
skatBstZbRD0bINUUoOc+SDECCeVBmc6m9mKU7/lpu0NG67L0o2Qrq05vsXZb8otBFtlLCj8
8t68DUjldx4E3NLKMWDxHAOY6fAQW8RLVT28To77yecKNoK58QPmxZOUUENg1ToaCGYOplps
Gn/qLoGWRsZLnjguq4ZArJ2XoSNo0KZ7zpH4T7n/u63QeOYQEINWHOvm+IjTi8NOJVcE289G
1J/HTuNosgYdDr/szKXQlDmfvSEDkB80OV6unTvNFzHhifBMKysWBRC1JmusbYF6RmBMTZqv
JKwiWP0C4zbueD+s9iUL2H812Z8h5aZ4ABYrfMaAJyoPZSGIgtwydedwvwCoAcF/xaDF1V15
w8/2EI+P3j5skO0jUNYPfm1HIXaPhVcMClHOXIb4DeIASApvWkaJt1MuVh4jyf115RARhcNg
c3pw6uhaTG/RaaoTjWYtCfYS+FdrEL9qHLcImTzHP0IyW3dwupJmATUdxahF3j3Fwu/Jbv9y
POyf8HPzB6vV1z59IqNVOI4zi93gF38bna19WdZxAX9OR/pnkQBfjsj4MUhKpPl3V0bEB1GB
lv4O1RR+Ti/cEZtuN07XHTLcILMAqNExZ/LVhcYvPka3jY+rpOBBa2kWQbAwQbyV1UAz33Ng
s8WihGgev1cfsQ8u2UCF4Lgh3HP/ARYHbMZ7U2P9FqLAgoVrPbUwS5qqIvRpKi4KK61zNbhA
YMwpzNzOO/DDUfX6+PVlvT1URozpHv6i/I+YDKNo7W0oWtdbcS2ZJB82mxCsJXaXB0zwe4FT
4sk2d5nwLBdPN9cDXipnRE4vNuGXNByGvXf4KdWp6RJyB3JFSe6J6YJ7XoDpW1AaX7rAJkVE
f1wOVkdkkTN6fWJqZh6Bkzo2dQcvueThRy6DxrVpTzicjaeQLoWifTPamI/pp0tvKy14eMvY
KsHzBXdbqxrtCsamp8Ssfv3Yfwar+fiE6MoXQ0+ixYyvGE+M4ARnO8Gs5rZ9qPCDcoPuLffr
8PM9MyElEcso846ggYbFukX+Srb/+nA+9eTMgHqu/0/Zky23jST5vl+hp42ZiPGaAA+RD/NQ
xEHCQgEQCiShfkFobHW3YmS3wnJvd//9ZlbhyCpkUbMRbbeZmXWgzrxrYO7f7fJoeuRvo/Gm
Sr59ef3t+Zs7rhhdrOMEeHsmLThW9fbH84/Pv/J3H2VPLvBf1kTHJrEjUK5WQZjoNu8cXm6s
Ha42okysIhllwj5cEaLdgbooY00nUIMx+fTf9eHz4/cvN//6/vzlF+qd8JAUjVW1BnQl59Zi
UHBnliSy1wAb65ozMLz/kGVit29frFTHbM95NVTx5jbcTWOQbcPFLqRjgl84ua5PHapFlcVU
7ukBmAFpioNeEp/wgaBnSeu2a9pOW3U50WqoTeIXHhzT9Ij1yk5TYyd5RQ03kEVH4AavUmhH
oC5ypGyTlOnx9fkLGrrNcpwt46GKRmXr29aSL4fmK9W1nBKQFt1sfUWBB+IW0kBSt5pkqYsP
6Zf4Pk+u7s+fe8nrpnQtyeKEDJpAw+3JUomdjPfiMckrlmWGwWtkRX2GBgicyybl1+Sh0Ygi
FugByt9LtWkrzWp5EbXxY49nU5M+f//6B14cL7/BGfidWMMveltT16cRpOXaGHNGEXu/jv4Z
WiPhP1Mp7Ydtvp1+CEswynfsx01FrniuAdEsLYT7ueOMafc2NEINLga0h712qIaLkbfxjeqj
2hOwZQjQ7NpX05nANabbmkjodDM9qQ4DmM4Rkr1Di60GPXkTlJFtZK+Tg+W7YH53WRjNYCC2
E9VkD7wEM5CU1JdmqJDmDxwqjKL9rHS2JOZwPL/UEZaMXk+pvTQQmeqrXkcrsJenZzOOUU5f
tJaE7s5a9v6AmDmmywmTuW+CDq2G1KyKoDZjJgrZwhwD4LucZr9AtrVL9hkxQJiAeAzfwokh
ZxQGRsnIc/3KY+bS96Arx/pAgZwBI1la8VfDyBBeoCyKJIJR4T0HCt5DtLG03/BTr2E1O2sm
t63Xx+9vtqdVgz78t9rvi+j4EbyP5Aakjh71F0VRbzHl9qE0rnueHvd+nSDqwFHWOBaCCd3U
vLiDJLhqK5jAWSsWFSxsncONoZp5sw3DokfrBP8EXhsdw0xWpub747e3F21bu8kf/5qN3z6/
gxPIHT3thDQHgcBsLcSGU3MWACZ6WvjV1Zb0lBV8wTqNO1N2uq5UGnNKDiU7qxU9dRjl8NWZ
LeMPCMeExEypo3NaLeTHupQf05fHN+B0f31+5VREerWk3C5GzKckTiLnlEU4xnUzYKhIp0Nh
wg4HNIjUF9ZDYSDYw4X8gF42F9vLZ8DnBO9dW0h4SEqZNHYmUUKC5+1eFHfdJYubYxfYG8jB
hlexK2fzQeNZwMCcWsqmYohQFEcryHxgZayaeA4HdkfMoacmc9YOrAcHUEp3c4u9Sjyi2JXl
ZCTpx9dXkrZBG1M01eNnzDc1W3MlnvwtDiW6D3kPo+ODwjv6KwPso3PsMRxwQ+jn1o78pCR5
QpJ/UwROrZ7Zf4bO2dcTlJzHhz7e1Xq9WNi9NcqVcw1Lv3a+A6R0MyuTCuGdUTQJSJ9efv6A
ouvj87enLzdQVX9j+TZ4JaP12hOUgec1KrDgvPGdAiqfrZ3qOHScbosmBqi3GX28hrKZ89rx
89u/P5TfPkT4pTPjjVVJXEaHJbtA3x8VYyAG4cC+HhBizIz2WVskhcljYt+eBmxS6D10l9pJ
DcSQDnlwueoxi5I6FQceOTsiBkTY4vl7qKkW2GzyS9f3uhcw//gIl+fjy8vTi/70m5/N/p1U
OcxgxAlG/9pdIghtuHCGhaJjTu00EsH3AmFuKzVGbAn7i43YGQiKOI2YnvU8B4OJRJowYHRp
5silqM9JzmFUHiFDuwzblit3FYta9MLKijOhIrm6bdsizYX2spiNSFsIxcCRRc7YsTinm2CB
pl52hGXLKzTIUHZpHjW8k8001+KcFZHvyNAkTdvuYLok18dUSb57sBlYoWIkQOlivVgxdWq9
ODMzzZ1nIDyqnekDXAPXrLONXIYdfGHItYvKb7ZlNPtfqxYvBjQzsoV7He/VLVYLJfimzW2U
H+TsEJbPb5/tswA40NF3aF4T/gXy27V+GE0kc4xk6q4stLGKPUZGtGEyx7isa20xhXQIB807
wxHv983sDDfBHVEEV8svcJnM9fNjRUBkH8ADFLXPRyGlHUnAE3S4F7xEe52mcQrmYLo1OjLh
3aY7n1fw9Tf/bf4f3lSRvPlq/NFnOkZsT5PZE3WvnxUZmPyxifcrtof7tOcNqYg7PlRJzYv4
Mc0iVab032gEavrHSMbqACzyHIrtudoAiyErjZWDAIAmpIBF3ZX7TxagT3tiwYYlRmGWsgd+
FzSbHebHSjD/GUprNKLGINC10IKZkCTi7WQi4jHF6JjyEyRAOxfpAPjqAIDYMlGMUO30yKn4
Jwp10g9HWAanCWusHby2tacS7XZ7u9tcpQlCT0hvH40626LFWSZzszFCHbexIZwVUURuR0Lt
LQ5ixJF+m8YcL5I1XmpkKva1FalpoNGsFpP2ieVYre6PZzCjl4vX4brt4qokk0qAWmM56Q1P
Uj7oZUgn+yiKpuQO6yZLpcP9ahCwJES9CZ+6W4ZqtQhorZqH6pTHXR9uqbxUpxpkdVjxc//B
nuxYdVnOLT+tL4xK4DIsfkyDMcKsttezqGK12y5CkfPtZCoPd4vFkmnJoEIiuIEYrMpagUCX
h5g7l+pretT+GNzecgnkBgLdod3CyvZwlNFmueYY3FgFm61lPzvCrJ2sCAnlE6+oIdUXw9S7
xqg4Tehtgza3ulGEaa3OFWYkJr6kYX+emHsxgUtBcrm7DQZWBRva32MxNVxETrQeLEW72d6u
Z/DdMmo3U996KAjn3XZ3rBJlGcV6bJIEi8WK3XJO54mCd38LPDPug9kp0zz9+fh2k317+/H9
9686Ffzbr4/fQcT8gXpHrOfmBa/jL7B5n1/xn/R5la73uhlexvn/VzZfenmmlrjp2bXQOxqp
RlScBjKJjtYxDuJHd+a8w/TKEHmEj2hQd7RxxfRi4LCyxV4UohOE8oSJiiztBj3epoKYbCam
+QPjZFhs1cvT4xtwOk9PN/Fvn/WIaT3vx+cvT/jnf76//dBKkl+fXl4/Pn/7+beb377dQAWG
HSGHKMC6Nk1qzMNgt4UmZ1RB2UDRCPv1iTFjAiAVYPlDBpAH9rmSqXRkaeQHBIjEdxl33ZCS
DXoHfbVb0znLstKR10zwNgwDKo8AMKz4j//6/Zefn/+kAzPUT4SOecvaGJWm1PWQ1M54sJCy
s6hzhJdpui9FPUv0gDi/499YumqyTRh4u8o2KZJoY0nnIyLPgnW75GZFyPh2xdrXB4pIxptV
y5Vt6izN2QCdsaxar+mtQ+FLBn6smuVmw7X1SfvbXVs+KgrCBVNnlWVs77NmG9xyFxUhCIMl
MwUIZ6ss1PZ2Fayv1FnFUbiAOcJ8TExXB2yRXOZYdb7cKQacaUsW1x+Vb8MoWFzrkMqj3SLh
x7ypJXANVwqfMwENtC2/OqLtJlosgus73iR6MlrfSGWDRpPJ964yPNmoU00W63zaZEyQyv7V
uQ30Nd/8+Ov16eZvcAv9+x83Px5fn/5xE8Uf4Or8O73wx1HyJK4+1gbNsSMj0rIwjlD2jUTd
40h7FDlvwmhMXh4OvlBkTaAwokW42VOnj2+GO/jNGVlVZeNY2lWmkUH4epvpv5l5gDtEeeF5
tldi3pgpwmmkRrT2ErYe9zSouiIfMGjMnW/+L3swL85DkOZTtM3WvDhi93tftKGhsZZ7EmrY
NbmuW1462CWtXrO+jztWSjgtQrGds7sGOAyFfxkI9Ey7ghbRtY6ILLpt6TXSA/Am0AECfbQU
eUJ1oEDZH4NhQKTvpPrn2kp8OhCZJ1QHfyGmFwOhcZ1xky/bWHz4azJyTf3QblBN0z9G4iwW
JNu5X7h79wt3/8kX7v7TL9xd/cKd+4WzRtxvvDKdu5XzsQgYg2OsRZiZbTZbcgNiyJUx5uww
nfcvNnl2lqqNPMnZgV2hvF86UK0hhV0565hA933ea0XjE2g+5PESJDV9i8B1CywZJyIMFL1Q
93WGUMI9JiTwMCw0xOHToXVwWwfhlit1DR/Oa8Ww+Ka6z2ajckrVMfLucMCi4GacpL86p1CT
ldWsvv1JweXjMSeYDj7Unne/eqx3EaiCmg5HEJNGrb/Q22WwC2KnSNrHjLFQW5Iz91Y1X0v4
LiRruBiwIqAcpoZWlXtqZ1K6kJ+yqkuqKtjMrnSNUuiCGDXs44Z6OPDlQGeEHuR6GW1hG4de
jE78bTS4qITXcmHgo+23cyNATgw2HipcnZpis/JRWP6B/UjXs7Gv3fcfR7idp1eD7/XSQ+2p
O/j3uRhv5B5+n8Tz7RBHy92ae8XGHCHY+d3talasUNWSkxA08hLfBjt3WsyZ6qwQqa/bGXS7
WAQOcB4Ja7EqjB7aavzobpVjV8fC3VwAPcKau8zBiWRoRX4SM6bKYdPHq6WhmwFfFrBjXPqn
+fYlZuXF1NU2SgerWlsEoZVkYsVJpMYfzz9+Bey3DyC/33x7/PH8v083z/iK4c+Pn4mmStcl
jtZBgCAMe8EHrCqJUfgZnPKLWRFGd6DBmWwdSJScLbu/BuqHWrhZw/oPiYSTxZpzBAMsCkCc
589U3TEdf4AN+KpWWR5aq1oDU9a5J57rEyhMmtd546RJIvtlVrgcsyIR3OElY83xUn8hAwmc
GjSMj8Pssav1hm9gMm/QRvRhRrOBTv7gFuSKP21P0Kv4r3ne9pTGcxvYskw19SxT/lwfxmu6
jTllpqjtsenJztptfqP4Rqd5gLKMV49kGI0eE1GnzB7WS56DJI0JlG6C5W5187f0+fvTBf78
nVOYAwucYOoDrhs9Ch0mH6j992rd4xSLCFjeEt9v0Z7yVqqFIk5FTWyPRdL0+R2oktfSfRb+
IUfnpUSia5xlpUSz51f7N9xQ9EQfgIv1HIiJNFxYRN0AB1gpd4s//7T2sIXJ+NeUhmYy2fGS
6VRLuFiEnJInwez1lnFXxvRux+LnpIjLuls68Zo6NGwZrW+JE8sE3Vr5QM5l3bA6xOahOjqZ
D0mTIhaVLw0sJTskNS+cUKIcBOIMavPn1Rkpm4TP+WpsEo1K2AESUvxEt62FslTE8HMbBAGO
Pmewxklbhpbh04xrIaNcsD2D07A9UEfmAWIn/8EumSByJw+HCSM/82/V0g+5P4miYbkTSlVb
FmT4iSmNPPZVTJg7hHe/Uy0uVhrMLJrceqkXfnOaSATToYGfxC4ocnK9k9b2dSlis+anY33l
Me1HcrVbbDEWkRPRAY3jS84SVDMR06QlHDXZoSyWE9b8NoZ8ctlBDa1dIZz1tclBMXXsgMML
7fOGHoMe+B7uXNTPLfeG06lY0XpzL5LhQx+v6zM6BQdPrICIeBHTnJ55m8QClquznLiqz9lJ
srsR7vFc0VOuB3SN5RcwQbuAeytqxK+Ymlb9xpvXtjrzmT0Ggj4XsM4A7stSN3wIiEXkMxKz
jLjZiHQ6WG7bRi2mYbCmN4ZLx5MwI+YXOGkppnZ5hDennKZziJMwWKzaGaCLFXm6wCmkf3by
Yl3nPVCywrxBFo71c4Lia3Uyg6014+HGbq3aNS0LLMe+LOJuu+IuUhizYEGkdGhoHW4sr4n+
EG+zOmJ9WOgg2nmG4jwkQT7Aq8TC2TUDbDYc3GLAJ/sSXuagVD+9fyIDCwZ39APtSdrA1vTl
W0mbwxzLVFsnCSYmojmrE2tpo9twKtm7EFHVvcPHIFAfGgY+TVMUgWxmu02dEICx2SUmDvM+
aHrIRJGyEhE2hse9dQmOwO7MiWYTuu84U/C+9GW2G8bt9Clr1IlZdKk8fwq2vjSLffFDWR7o
mB/OMz6hpxxjI99bRMeTuCQ8c0qosj0vJlES9PhliT7Jd3m/3hv++tdLoBAFfdNA5u26c7Oc
a2BaHViP6rxVF65ED/U64xES5HEkzctscG6wggY6zjMTLr2wFx+a16kt7E5tt9b7yPB7HUAF
RDa8Uz8BkeMm49RZ2hl7YBhvV8vW2wX9FDXd2iIvWs9KK0TjTWNEyRLMovz+eoR/1mVRynf4
ksKWG3WapQ4fxjjot01nfB7b1DmLWUY5r6Ku5wa5cuUd/7VwKJXv8Dwmw3afL8J6Kw1OvqO1
gB4SDIlPPXlxaJ1JofDRq+stG+3t1OJ9LpZta11/9zmyub7m2qToHPRQjr5kAj+6PA9twMD1
TqDEJjDaYwtUlryUC/JNjuEChDoStwtqEegB3UnYXLGJDOcZ01oWdnZq0mTNBs5SggQlT8IP
bIPlLqrs301pqZR7UFd52IEBr5PNNZdMNWzGioFsG4Q72n2E6+fG6t5ayjZSb4PN7r0FVsNe
4JVYlAizwNbsjA2hZ5Qb0pKvI11zbask4VS2lKLMRZ3CH5vdStlY5zTCvBaRV58BlybLslgk
1BSWqZ1li8pUsFuwx7CSymI3lIx2gS+Xl2YJNEW040wfSZVFxghm1+epENu+jlyFPD9oDXSE
8d/tO+KFavQNQsaokcjWJVQ33MPm+vz4gvD4onmpvswk22ik323P4OESwItmXjCr7reLDT8I
hgIOfuDBOCbM4Ic0dvO6ZxnIHLyOrvPWaw6m5gjfPK+aU704JDA1HoanxzeZO8Q6pGwGxKA4
BridATPZbpkR1lFf88RlFtEZZeKiYc0l/bLwcDLQE8vJXVTVg0wExzYadTER+wVaX8kVU2Qn
/rB6KMoKPRxoFhRYjm3+vkajSY4nOwGWgby3s9ixIPhzRrI8wo+uPma2hnAE+qRtJDjj69vW
62ykjUv2k3MBGkh3WftkxZFg6SEg1ZuogOufaeTumQYbwSHNR5HGMZnIOElt3ywN8I2Duktp
5srjg5MvGAFEHasulsEhzdoktm0QKkVzgYmqybIbwM2D5HtS1PhiWSol4LHRHdocEZxiNEav
CbvMoOF1i0wEJgZq76lzUJv29Q7QSK5XwWrhtjZmf+HriqT29JoX2q6228Bfans7lpqAejH0
UzDCoyzClJPWoPfKMrsCjBQePoumSImq/KQ8Pcnbxq7ZnGDtRTzY8Bx9mJpgEQTRbA6N7Opp
YcAGi4NdoxH17E+YspnOSA24CdzPG8U173IoRP94LN/BooVqPwngDmbTKJrtYjmb+omd5pod
GEvDEbu97VlJX6Ehh6xTCjkUTxHgioNFSxWRSS1gGWWRcr8mrrbLbRh6KkJsE22DwB56XWi1
Zeva3HqHxuB3nrbOWZMoldgt9XFTBzhFwhr/ppZ0nUlQ+0JaZkA7z1iZOjq1oVxtmVwRCNfj
KnNgg9mJwoSqkiR2G82avbD5eQOHHZxVNSsDjwSnIpPUF0YjelPAV6dCX/w64rQnZJrM6zJB
inZFsH4itDWzUeSaoGwFDWXVwDJCM6NbfXW/WgS7ORRYy9V4E+BDDvL3lx/Pry9Pf9ph0P20
dfLUzicTocOlEITCaWUgGAfaU0Gf7t+ZnaF27amRJ60nlZ5NLPEhNMu20gfmKO81B7iurSIr
pbHq8oeipf4FTA0jeZ4RE3xV2T+6vYr1w+jU+lrhKwUYYM0my67IU+kEJqsqsavWY9NzBLTy
0letdjZxe6IdUJqGPa6sT1P5kXp6oeVjSKdoP02rUdrLlJfgtJkF30nEf21ms3X87e3Hh7fn
L083J7UfQy+Q6unpS/8gBWKGl0vEl8fXH0/f5+Efl1xYHDj+nlwBpC/Bt0XGWtRtCklVoBTF
WXwpXpvb3qle3/C+ChBZq4zXY1NCRmHN011LfG4RDnf8u5S1cN+o4MnMDfw+nSdogtKwkTWU
wJZ6KOanh9gTI0GpNEubFKz9sxcDavEQESHgQl+hgZr0QE/oY5xH9i/b2WeA2GoJDTU2WxuW
Ws+FaBDsdKazGoWv4BGPmyxcLOBMsPreWrn5NOBKvALRDIGs1ZS8xjAVtRtzZNmo0JSG/eP4
YFHttaeRLXdzb6VkKvaopM/zZC/Zt9fff3ijyfSrNRavjoAuT2JOVWKQaYoZLexnfQxG6ZSR
d1YaN4ORAh9cvjNJWMfcji+PcBONHqpWBrC+WHmCc9jzaJEh+VQ+XCdIzg7ewZrYDzJWvjdl
TIG75GEIZ+3hAwTOX7LgCbTSsZ8cPWC2Wy9mx2Gau33MtHIPktF64UHccq3fN2Gw4RBRXqlb
EEboshiRcf+gWL3ZctGUI11+Z/o5ryGpdr4XFEYaD9tp4fVTYQk3D00kNqtgw7YOuO0q2F6r
3KxVZihzuV2GSw9iySGkaG+X6x2HodzZBK3qgAY7jwhVnEGautQAYKclk5xmZ0QXyaWhjlEj
oqySAk2qXGcquBC3Vvzb1J25PWGamzKP00wdO518mztGpmqa8iJA0Oda0DtNWc+aTchT4Vtd
6vh/lH1Zd9y4kuZf0dP0vWemuriT+VAPSJKZSYtk0gQzRfklj8pWXeu0LHkk+XZ5fn0jAJDE
EqA8D7ak+ILYlwAQi/huPdtGjb2xNAZbniJ81DTBZTie8gOjrI/cEebnOktOOjjqrzOxA8bq
GB2uef9Y6ywsmMqZBP68dFTTAJyJF8JmOn4CmVm2t6gvrhmHN032s+uQTEEMJ90gnOcgac8w
E6wd/p9n3vy2kw6YkIR4NGgktoTFWNYg5DjUW5WClSChog8cSqZ8POihvxd0B0Gizaw0Llr2
EFv6m07Nb0lH7CSh4C5VBs5wpmymEmL2Aj+HWqktDY8nOe+slDEpd7MTBR54WMcvZV+AsMCo
6saoUDWRdabnxy3qi29m2O8CrFD7XvcypwGXBpMVFxYm+NVlcxyQdPmJhOQYRKuiBDV73WX7
DA8N+my9pCzsfOymEcAl0DWcZ5gJp311xN6iZxbwhAC6Ouj3TE7Ly6PDTFHn2hJUJ2hhGqp2
rx7rl8rfVAX7A6ndp0PZHk4EQYrtBqHuSVPm6jXQksep34Jv1N2IjS8ae76PlAxERs24TmnY
+pr1NROYfLThdrQiCRYhS8yYASyAlXEi/pYznSXOzs3a/iK/goWE5n2JWt7Kdb2iylWToGUZ
mM6BCh5IBVaypEj9CN9lJAP36cV2I14AZ9bbhvixZ2ZehqPHjkvDoPaLgFipNpE/SStWuRgM
7xXnasuDD6wUcBJAZFLuxmFSVppsQniOFPFnzGMEGbPNJpW4O53cD9MshOzwmjUNEx7ttuDS
6LYsjaAeCliUEOl6ra6cjbeJs3jX4/BhY7dnX+5PNQ/jYFfPHGkdTeLAz5YaOjMjYxewsdWV
12YjDDd14kWeKKzZFKfpQKl3JKkbQpV2tVqpy3exl4Ss7ZuTs0yMKQNTGvvrm0a2v/tbxoKW
uL/OvHgRre1O6Y8DhLEBObnAOrggaZB5svEdDukk48aLAzFdneUEpiSc57Qxo8c61D0QacDq
bl59pEGyIXb584aELlV2+WlRMqEE3CKz37aoOq8sfH8OEjZqZFuY5edwEs/wTwxOXV/z54YO
4oUjPUXzIJ0WlQXrmyqaPB4uD2BAdLlU4yCTRrGnMYB2Xmgkzyh8gVejXAE9KKQTN5Nf3ZIk
JTApoWdRtGEvabjBigBjzDOfhOLpwuNw9/KFxwKqfj9eme5wpBtQ+Sfij9Tg4H9eqsxT1WUF
kf2vey4V5I702m2GpOZwojCpdbUV5xiNqt0oCpJ8xRs7ekGSkfZpCMJI8Phg5gCGWVg6HVac
I+itko7qfiNEE8B7H6SEvUlwDnGpQTWR78Qh5BOQifQmnSiXlsZxhtBrTfaYyWVz8r1rPGbA
zLRjkobBIl+RsCE0W7Bid4/ilu/r3cvdZ3jhsHygDqp6zFmpIPtBjzWPg9TSmkyBR2bOiQGj
sbWL7Q8LcrhRuBcdnkEBLlsm2BtOpqZeaatxw3bR4VYpgPCM4iSyZCF6WRDPLiVqHgUPjMkh
kNc0Jen9y8Pdo/2mJ4VI7sg4V+9yJJAFpvPSmczED3Z4zskAOr0iYAv+iKV84idx7JHLmTAS
foujcu/gjKQ92WnZOyzrVJ4ON95XONQdQaW3Pdcypn9EGNqzRq+aco2lHIeSHeEKV/Eb0t46
YxCqjOKp/nI+aQ/ZKgeP8iUdRzt6CtwKAMc7efWUoEPgUtzo6lMKtM2bIAtjchqdA+XmvWyH
IMtGPHmpuulKe4ro+k4OcJzU/eBoWVDqSr/BHXkpHNzJP/I5hMlCzDuF4+nnp9/gY0bh85K/
29pO+URC07upmYE8aYl1ZW0qCMYOjxKlsrBFkgxWNyg39zhgL5GSYbnQReli+qjhjzDcml4T
iiy1kgO/t15A93oHOdbVgCU6QViLOzjnRcS3UqMHJl2uLE4HakcDmZpdc02uEJ398IE2Vipc
NRkmBTJ0Z+z9utJqV+nGahKAO1HcK4vMA2tjmuftiF2pzbifVDRFl4MZc4rhkpGt3NuyL8j6
pJH6kavzSkh9HwayPzlVODRWk01nApfd6CrfjJTt6BgixVImlZo2MdOncG28ni34DDDTBfmU
jV6+PylOrQTYd4H1AaMtw33x6ydReKWuO7QGHKpa8HTLcXPsGrhzjOdgwsDG3KWo9lXOhJ/e
yoqH/7TrSrse26WB/AvjX6rbW+1+Lrcnq+GtPeIG1XGXTVrYmzGjrax7TVVvSwIXJtQ0PpqD
XGlyoDnO8qGvrdt9CYpIzG3h8n3ZgXFdR7r+cjjzEHv5ATe5ueypphLYHj8dXXaGp7o2Na5m
kLs4YwtQi3kfP5ynKK+KeM5op2Jr70fgL0gEBF1OC8Lro/IisNAuwrHpLHJzqqpiUXdYJ3Wd
S6VA+CVbGWxV11TsgNwWtVofTuWh2gvwDGbQwQe/eC1FETr0lf7WykGhjSpeJ3YEDRPE+Whl
fUrZXuBivyFDfiiOdn786uW4wx0zSNH3Gp6UgHnbOKwYO66u7mTUk9sOM5PWMlur8oqy0M2l
B1tMxYphJvGQ4+w8rQVkWdAtiUIfA6Q3OtXwZcZASOnbPVaLhckw9VkAETkKybJRB/RCLsfb
VvXusiDQslgO8Bo+HNsS+yZnq0ireWVesJFJ6yV6G026Duzam0nVVvri++w+0oNOFNcb0R3i
g9s2dri6RK7rx4UB9SdB8z4wrkM78KRVG8GwFY1XR0mXFNjAYqMDyYwB19q4ac9arETQZJPL
2PKkS0ZBh5i0cPJXs4EdG18tc/avw639mRRR3xpv5XP17EsV5VJQToD+xPZW8Owsgofb6mJM
IrO1xNQ42eyPC1dCgLBR2irBABGoE1tbAGSnX1Zx5WKXEYUSttDZXtS1eTl4kEjEmRp8Rvqt
uDBjidZ1yQ6NjkxnbeyfNlVTAJ/I9ZBHoZdYpWRCH9nEkfYwqEN/o10281QtbNorxezLvZ5r
USof2iVt6jHvaqEHM8XdWGtCvUwyyDzcPznKxLUyplkOqZHHfz2/PLx9/faqjQ0mM++PW10T
YiJ3ObrTzKjmUdPIY853vmOEkN3LgJCrzxUrJ6N/fX59U6Jd2jdoItPKj8NYb0tOTEKEOJrE
pkhjY2hIR2XmsDhUY3wosNteQKtMdZDHKTQ/mA0IERuwa3zAWq4iEOiJCH8KbGSf9HLTisbx
JraICX9o0PIEe+oEO5QDeK6IWU9G6vojvo78fH27/3b1J8RZl1Fu//GN9dLjz6v7b3/efwHF
998l12/PT79BjJF/mv0FpzGjEwyLGE4bNr5NudAanirKEUKagVMKVd+GM42jqrLMlzZxSWas
d7a5x0S+PrZmCuCIe9jqxBzsOUx5nc9xZ3RNsQLQat+CMrLlMsWAeVXfT2W29/7pYtCdqHB0
Oqc5ki/3gTfoCZZNeQ7MdITwgqmNAipNZgyKcGDKBL0PZT6oj2liju0PNZHqN+pc2rLuMhQB
gNxgl/kCYet+J7Y5/ZNjF6LW6AB++BSlmWfW8rps2KLs+KTuclV3ia/kugjISV1ubD9DEqv3
S4KWQmAco8DNOYlGx2UIx0fHEzWsHkI4d+JHrinqqNmx0aO4c9oNbp7B17acrDnV4ywNm0hW
ol3rLmE3ouoTgbTvz1Wr9pkqr9YUcl9Vxkzvr0NDVKBhHkS+p39ID9KLsr2qNoaTThXsemM5
o9Zeyk8QO9dmINDUHIr01Cbs4BbcuJYXJph/PLHjU69Xg1+UX7adqiMF9OkK38xnol9cez04
piUDtIuWz01jLBviksyg1b1J6Da62xzeQzmxpdnybyYNP909wnb0uxAT7qRlFRJAnY8gEaHS
UY+BgEuMczNJrMe3r0LQkokrW52+jy2imkLcyQAqivSDSjp6T5+MnYUv/MbwEdsej4BnDSSO
QeRAiK7q3DAg4gC+4wACsptzEgoW1yFFPWDMWYZqDMKipUCBeB+DrnBT3CgAflt3zt9jaaqu
4jyGv/AljQ697e+0AB1wLdHQhuuowWFEOXqrbpQOPI7OclgSWhe0MsKyL+THBwgVuAweSADO
TUuSnR6vgf1pe+SWWDt0nH2K5dbRKQP7jAfpsEM6eO665tckiv3UAvE3axSxY9EumNza50L8
6/7p/uXu7fnFluaHjhXx+fN/Yec+Bl78OMvAFXl+bU/2p7s/H++vhPeCKzAtasvh5thzE3h+
9UMH0nTwpP/2fAWBBtnsZevBlweIM8gWCZ7x638qbaJlCLf+f6j2s1ZZ5+/ME5t0mDMBl31/
PHWqeW7VamdRhR8OersT+0xXd4CU2G94FgJQLhtgQrrPn1OpuM6fooA705kozXow0nPniOoZ
fyJuGz/LtHPFhBQkg6f+U4eJRwvTxkt0z84ScfsGmjiavAtC6mV6nFwTtREIC2JcAU/I6Mfe
WpZs692NdiMIlUc7p+l5G8mKayKu5HTMy/o4YF8u3imow3JqTuOmtstKYw/tLpqiTkhneON5
yJAwTmc6/bLHRpGEYjeUIMMMDmq+LghoWLjWmPw0Z1wMTVh+u29n9wBW2i0mAS9gZ53yFiyA
NPEnGeV7g8esWtkzGQlrqTBFukOwX7b7KEeHDiLzmyN5JMjwHkkQY8Oe0VOEzrZKpMjSZQMO
ZAhguX5QAOn9waohh1JMclY4Es/P0FJnQZBgqQKUJPi1tcqzSdamUFM0m8RHxj18OmpRA9Q0
9fBJGhRjUa81jtT98Qb33K7zYOFHdA5kgf2Y08hDqsMPYFyYktZsVqaCg24Fx9pylKc+vu0w
JMjWu4rmGft4dZ0vmiTBky+aLIrXky/GeG01Ys3m6+p7CgLaR6uJN2ypW2epO0JBTaWyhKae
iWKvd69X3x+ePr+9IHqH8+4k/AYhu8fh0u1yF92xxDIQhBoHCt+JGyQU6jOSppsNMm0WFFk8
lE/RfpzxFPfHaaez3ugL3zu9ozDiarh2CbNfTDD8RT4sJITNlaw2eYJsPwrqr6GrPY3P6gVP
f7V5yS8yRr/GF5K1XaX/RJAqM+paXSNsD1/QeLUhIuy1weYK13KI1nPIf7UFy18aURHx1/Pb
riXTf2odg4oe0oBbaqBJA5qsdd3MtHEmnwaOjuKYo4sBC50tDGicvtu+wJatbzcz29peLZlC
slaRtTZMg3VxQbCNxhIkD8+ufcdORrwarO+AcBfruLhWeBI8vvvMAdew9tEQlMtovskSDwG5
XgcmE4jr2mB9J5Fcuv9nlCeNUKlNgu8ncBDTHk+g6fx3xt1QXaojj/W7ktF8O2wNp/l+uC6Q
fXlG2ZFsDaZ1gcjo6tfo8rgwjKjxDVLIZLtaBx9ZdRQ4QLcrtRihJYY1918e7ob7/3LLYWXV
DrpW0Cx0O4gXTH4CenPU9JJVqCN9RbHiN0OQoiHsF4Y0CZCthdORdbQZMj/ETj6MHqQYPUh9
tEJJmsTIQYnR0w1elYTJDO9VBZ3WULhkfaoAS7oudgFLtnpOYwwbVwFif/UENiThJlWvKZ1D
y/x08gptt/HQdOc0xW57yo+nqq62vfAdKUEQ6jUjFEm47AgdIELlpa6aavgj9mft4+POOApM
n1T9Rxk4w7jOdFx08TdjEbReS+uSg+aRTbqcfYMqL1INal/uNbdWnMjd+3jjdLXd3H97fvl5
9e3u+/f7L1e8gNY05t+l0RQgWE/P1HYQRONCTSGK6z61bQQ4HBxHGFEV9vG27PvbrgLVCFcj
zsoNZvIAjHtqOxo12IQahCv5KayZ3gKzBYtOLm5It7UKUlbi7dRdBlSTT6gVDPDD8z0r1fki
3f04Lfh608knJ4OZsrtAh/oGu/vmmBFunNN4yJAzdu0h4NnkyqDq5ihisG6zhKajlUXTcScL
rixmNQONOOZ2Og7NAmHWCs9kWH9pTKM59uFR18qoL7BHfjHxSUPiImDL03F7MtKS9i9md9Pq
iAuOAm3hFcvwv2qwrI5AtuBxX9YrS1WuO0TgZP4C706Vwz4q3gucRpkaFIMTFflMTw0LB2Bw
jFmMHzk4LCJjUudcl8/6ZkeONe5qUyxiELzY9NQ0b2nOhXZWPuPU+7+/3z19MZ75RfLC995K
/kW7Urr9zQVX8lH2BbP9OTUYreaXdIfRp5gZoF8a2i0o6eanCFOKXUNLGLxqmKvF0FV5kPme
lSUbWhtTXVt52jeaXeyLu8LuDqsz1AO1oPbVJ3T/KVIvDla6bluw+vrNDW7CITYU7ovDjX8g
7afLMGCvpRwXSl72ct2FmwiT7CSapTGXVY0O4m+Frq/6PB7iLDRXszrIdI0Sudxoru1Ej81W
dCYA7mC8LLG6npGzZMS4N77ZS5IcmOSPzZglJlG4jtEUlu2xIdV6q3ensFC8dcovQzaadWhq
tssejPqKZ32dws674ITbN2vAkFJAQWTuVQXbdX3Dw7ZVCV6L88PL24+7xzURkez3bNchmsqj
qMIxvz51ahOiqU3f3PiTdOr/9t8PUrGouXt907K88aXGDHd+eVQWgwUpaBBlAYYY0oD6iX+D
2zEsPA45fmGge01LCqmGWj36ePfve71mUuMJYgYaxRQIxQ0+Zhwq7sVaxRUgQ9MUEHiALrYk
d7iAVpl9bNXQk0ucOQX4eVPlwVULtFRCz1HH0HcBoRNgQpOm5KDDmP9VlSP2RjxloW+LAo5C
ZqUXuRouK/0U3cn0wTQfesECToRyU07CC5Efecwjk4kbRyKUb182VYtb3GHc+huagcCvg2au
q3KAVRaDh0p1dqYyCKWTudJocbmZwq+Wth7yYBMHeHHg9sK4c1bQ2dPZO1ms1ti2h1PRWRx3
YnM9caZe6v8udmElWFvx2ADLFzIpFNOy5G6tFqwF47S1z+ip6+pbnCouThzYFDl9aXiI+AMc
2P4qj8ikyC9bMrBVWvPzB8qlzm9BmXEPdkdM5vPUR0GZ0IXkQ7aJYsWoYkLym8DztTveCYEF
AFW0UBnUpUOja7Y7GoLdF08Mdbk/XspzaCdKt4ri11RfIKqOWHmgVE5eyWP7Efp/xKosIYfP
N5PrUHxEKs+EYN0ASEUc4vHcf9xB4ErWgmHJdfIoCONCp2bZZXcq68uenPalXUx2PvJTEBuR
gkpsrZ84S6BeKU1VmJwOajapEuMuIz18X514QJ4PsIvkiUFfmZekeder1ZlTHMLEoQOwsOSR
nwTYyWRiEU6EeIiM0Y8S1WBNqR53mYki4CsTK/ao6/ZMgNDQabZbrEZsAEZ+jI0TjUPXyFCh
IF5rYeBIw9guFANiX9VQU4Fs4+GAoWqgQonjfXGe3802jPCngYlFut/E6jMNVj4FxB4Z+fZU
mHyr20g/xB4+kvuBraaY8DeXnG0yqoi3zMVp/0FSPeXU9zxs3s2NJo7pSNcUm80m1oSyvo2H
BPySOjaNaXdS/7ycK80ZiCBKywUjiotw5XT3xs5GmGc1cNNIwWFu5Cs6aho9w+iN76lXozoQ
uwBNjtch7B1X41D7SQX8NEWz2wSRh30xpKPvACLfwwsIEHba1jiSwJFqqs0sHcKvFmeew+Cj
5v8TzjVfsSLTHO6u1z4dq8uOtODPgx17azwReGlZS2MYOx+r2xZCBZ5xdz6CI2f/kaq/5F1/
xFKY8I5iTnEnLu51YCibzm75giYB0s3sXJ5gA1d6qAV37RZWxdcX0mxtAIK+jDHWdLs0DtMY
95onOPY0xz6cHDEThyM0mfxAh/LEDi8lxRLZ17GfUfz6QeEJPIqd/mcOJlcSrG8YgLvylLCw
XW3txj9Uh8QPkV6ptg0pG5TelSPSI/CexBdG65MPeRRgbcLW194PgrXZxE6EJVHFsBngm1KM
tYWA0hV3XgqfQ2tS51lrWi4BxchCCEDgxw4gCOwm5ECEDl4OoWcKncNHBzATvAJcGFBZEi/B
NmaNxd/YxeZAgmxJAGxSR4lCPw3X6sNYEsOiWIPCtd2Jc0RIE3MgRoY7BzbItiWKukGX9Cbv
Qm91SW/qsS/3fOpZKQ95EkdY/ZhkFoRZsppu2e4Cf9vk85yzC9enbDnBLvLmIdOobiYWaopT
saHcpClKzbAUMqTdIVgROuAbh1ahwrA+pOtmszpfmDSCFWfjKM4mDkJMS1PjiJBtTABI47VD
Lu6BKzroXuckng9p5iGDGICNh8iG0nwGG1MtJeHqSnvM80tnmKopmE3kL3Wqn4uuEdFn7XXe
jKeDyptBgj0gaxwput5vwUnpDve1N+9Zl3y36yiynbW0O/WXqqOqBeSM9mEcYLIJA3RjoQXo
aBx52Ce0TjImSaBbVhOws/9a/flGhE4rASzXkShLmPnoviLX/bWBLZZ3z7USB9676zhjiV2f
s7X1nYkOTFHkUIJXmLIkwy7yZ46ONRM6fromSZNowF0BS5axZHsfugd8jCP6wfcygl9QKWt6
5LFtfyUTxhKHSbqxB+kpLzaehx5ZAAocDssmnrHoSn816081q51njxyIU4GKjarWlnMHovJV
eLVwdDtQ3J+txNl5C+02BqxuvQwP/0aLdRjy1Q+leyLk05KdBSLHPZzCE/ir+y7jSODyGDm9
NDSP0sbfIKs+HQbqmEe0aZJV2Y0dXfwgKzI/w2pFCppmwdrkIazEWYAIuVVLNCNtlT5ip4SW
bUNYQkOeIqvpcGhyTFobms73AlR2AmSt8TkDso4yeuSh4jMgqyONMcQ+IjOdK5JkCUGAIQtC
NK+bLEzTEPOeoHJkfmG3CQAbv7Bz40BQYK3FobXW4gzI3ZGgw9oAircoXrOFfUD2VAElqntv
LgURzVe5JEHUWTO6scHBHwypHsJlwsqm7PdlCzEP5DvZhdsNXBr6h2dnxleylayOO6yIN33F
Q2tdhr7qsPuFibEohfuo/fHMSl12l5uKlliKKuMOrly4p3501cE+gTAdIl7a6ifu1BHG1fIC
w5a0e/7fu3m+U7y8O03sq0mVzUmE3VgpOddqXi5qIWbPMtYkFbxtYcSsaWb6PNmuQ5v28dhX
H20y7UrSI+RTm1U2uT/m19xnAjIXQO90tUk4AxvnIcY1lbzqr2+Ox8LOujhOCil6toQRCrKS
pPCNoSS4vCcO19h3Mqzx2/0jODt5+aZFFuEgybvqqmqHMPJGhGdWiVjnWyK+YFnxdLYvz3df
Pj9/QzKRdQCvDanv22NDunNAAKFQYbcw6Ki3FE3pQnut7WXJncXjhR/u/757ZbV7fXv58Y07
0HHWYqgu9JijK2y10rXgPy3EvuJRaVcHI3DEqxxFT9I4wFlk/d+voQhPc/ft9cfTv9CRIjMT
BnurmblSmRpDVTBY+pZn8vHH3SPrppVhxN8jB9j81GZcPA3wRBtMeFt44Dr9QmoiVcZksZ15
L9nMZl7unuYWhcgUvj6wyQ9XXCf+JuFOQHHRbVAsl10z0B5vyO3xhHscnrmE43LuH/hStrDF
Yi8fMztEj+aOlVjC6u4+M3BDHGs9url7+/z1y/O/rrqX+7eHb/fPP96u9s+sIZ+e9ZE0p9P1
pcwG9jN3gq7Q7fS4G5Bmk0+UC/JNXWjZhHEAMZKWDNyHf5EEqF91/kgwAUhDL3eO2NcyogT2
/czzqap6UHZby6RmaRRquAd5iEQzlVtUCE7cVxIltNkEiYe0EziT6hs4QatttaTPYEqazWrq
wswjQhpbWhUh+e4GVknPx3OVzhzX8ixu0PYQ0ezXOwHW53WOrh0jz8vWmaSn2LVCMmGpH3Af
/tMT+2oWTFQaVzOY/PejjchOZSEoG/VDvpaGME5BC8nO28F7rQnvBq4mX1jSNAnwvmaCZgAD
Hk2cgemp7kx8Svc4QmATfbYMYG+FDDjhRBMrAd9mHDmAM9jLftxukcEtQKzdmrKoyFBerw7g
yYsvUlZpR4YPHOH4xdlkE95/InidpK2ineu8V6LZDoXvO5aBZcjBVrpS5447S0I7YTJ6Ws+A
1FWT+p7v6C6axzDKCtWNaRJ6Xkm3+igR9iI6TRoM6J8zATXiE8wgcvlX+3yyz5TURTVOodue
IVW21AuzlZmw75ig5IKbDqruuYYxeCFOPL3AXXVNjCocj9elgzSfryf5IlSHe3shgatTTk2t
jqjJnOS3P+9e778sskJ+9/JF9XOUV12OSFbFAB6xlzsV1rPdkdJqa8T1Qa3fWCMTlV0h639d
DkfQmc0rNHGNw5UNx+kxtz4UUSnWPpUcTaW+yIiy72pCDwaRYsQWI8qE9w3JL3nTuopm2oAY
TOYYXoJF/PXj6TM475xijFpngWZXWDIx0CYlY3xsMwYRrnXf4SooPAkapr5vJcyo6MW/cBRr
GrrxT8gQZKlnRIvjCPiwP1FNl13QIQYgBNoSYVj0EnDwUOfuknMOqgbVATJr7HjjqXfInDoZ
0yn7EKRhaPcuNPmgqZWpgVgj7sYmtMpRfwjQZlxLWXUpOBFVIwJIRcrshhf3GcEOfBOYIEkl
IZKMH2MvbwCCBez1NtyERu/K0zD3wKY3157t2OCedlKDUtsr98PR7AlJ1KOxcKALNBcbnDay
PHtNk0uQg5hJWRb9UCURW1ClEz4diONRAMu13gCOsqHT1I4GKiub6/kJpKRKN+hVECP6BWQN
wZ1qlrNjAwKOjzQJMN1iALkJZ94cC9XNAgCz7aZCyzImKnieOW4FGX8tnfHEwzWDxcAf/ShO
cb0JycBF1XcYHB7kFgbUFnyBVU3vmZqprsAkNdt4qT17GTlwzR9LYXwhZmaXgn0PqlM1gVY6
0wnYLFNfDphOJECKWv+8twsK12y0qdKPg5pEAy4RdJrqpVItyGz2qRInbWyVZtrxcuJ1pj6N
cZI4qBmZl/kUyF6lVlGajOgGh70Eq3AT609vM9G9GXOW69uMDWhsgyPbMfY8qzBkG/qS7CqL
tFkW94tD8/D55fn+8f7z28vz08Pn1yuO85vll7/u0NsdYJjX/emK8dcT0gojQib0eaP3imkY
BjR2eCBNGLLlcaC5taQKW3C9w8BiJLNmBUunbpyjWTiSXo6VHU18T7VsEGbcqmG2oKTGoFTM
vfXsOR1V3ZrhwE+xUrPqhK71V+KGwbuSIvb8PcOa/flM1czPFWqAUzFZgGFsoQ9xI5vhpo68
0Dlapf06Iqnd1H6QhtMU1TKsmzAOMelGNJJim6+XMw/jbOPeWYSBvSNZ7q/DKsgxP7RkTzC1
Gy6Fzf4WbCLWkjmN0jrAFJl4izSx7xn9AjTd446gwv7hTAbbRxg1cqjgSDj03dGFJxaINr7O
4vKILJatmyjz3R3UHw8N3DA7XNarLNxO5qfrc1RPRC6cYcAmmRGuYYE4QK1lfoBdDFOvkF/u
jKm3PExYZ40cLAFh2S/xduSXz7SzJpQesM51jJtvSmxNu5lkWrUuwK4aSzYVjvUA+uwIA4T1
PImAxPTU6GFtFi54POdv5zMf0nILOxMJ92LxQtKSYuZqAnA0zZIYT4AUcbjBxoPC0rIfii2I
goiDJtYU8jCLfWQc9BZkPi9i2Gz8hVQC9c9i9+t0xENSEGe2dz/Xj3Aa5gf4DqAxBajdkcHi
o2OPtHEY62uwgWYOl+QLm8M1xsIgTm1Y+wvkHKt2Jhoax44hWtGanWExYV/jSYLUJ3gKIPik
77UuZ1rvQW5eO2Kty+WK2Imo7iB1KMvQj8Re66gNA5MU22gXHjjlxaofHQ3i5zt8IKwe7jS2
LIlwl34GlyMkgc7Fznjv1SfbuOYeB1NMoDF41LOcCTlWBuws62RD1egMJtDmd/VKFiRoAeU1
iynL6Rwp6sBT58k2eOZ557M+D9DMuzjSozuoWJbFmA2OzpKMjlJ3H9MNapCg8LAjOL6gcQSd
V7PPDhSJM0dl+GF/tTBmCB0F2VYOICebKEbXPMzYX0F32egQKFWm06fSf2f77s5sYdcDRRhg
9gsJbFwJ3GDGigvOnxb7rjng1ZSm+gWwvFPZWRfm/fxOdHs5C0sUi0FVWx+Op/xA876E55th
qNpbrKOmexK0Avy+ZLVE1vWJAg1R5qGj27yvUZHmHKADigZNRzx09wWI6m8DChg3WZqsD33T
JF9B6j07V3moECeE/u3xyOPmYR9zhnNf7rannTuF7gYVtOWB53Ju1JcDBb/NfC8heMcxMAsi
7CBk8KQtljZYavhsncFqNd+IoBkDGuCXjjoTW5HRETBfpjgxfOfnmO8usnmnYqAZGoTZYNLu
QywM3WGUGJ72gYirliMAn+Y12VZbxQC8z+09EiIvYh6F66rPtS+LMj8WcDhdHs77S1vOwFKK
ii8JDnqi0Jen6/7y4TynhJQGNLCP7S2aJiXt7dGRKqhtd1i6KlOTw0NQsZ792HRo7pXwYYFl
3udNs5o3b9VzlaMhevPpAvmnSmmPQ7XTXPZzTRKOgWOoo/ryyJM4pGGgmZYDVSimEOywssB7
PyCMx/zWed3My0Aaemr3bM3EBhXnGCozRb6IOdi5Uo5Z26WmukLNBFx2VT2gPTmxbYv+fCGn
4UjLuuSB1hav/tOlxtvP76pjQtnQpCl7Yre1QNlRvj7uL8PZxQA6PQOpVzh6As4qHSAtehc0
eb924dzHl9pwqrd5vcpKU3x+frm3Q4+eq6KEKac+MYvWOXK3HLU6QIvzdnlj0DLVEpd+Nr/c
P0f1w9OPv6+ev8MN06uZ6zmqlRV6oemvrAodOrtknd1VJkyKs3kZJQBxEdVULZeH2n2prHo8
zd1NC77c9GKwLRr0oBFq0YimqfaqcjJWWa3pp4CzSlMY431pb2hm53hX2Pry4wlGgmgOoWrz
eH/3eg9f8iHw9e6Nx1m959FZv9il6e//74/717crIqKTlWNX9lVTtmxcq/YHzlpwpuLhXw9v
d49Xw9nuaBgx7MDH+od0A2w5fqJCxW1LQKWA94+mMs7REgKw0pLHX73URwijhqvXMeZTXc4j
YC44UjR1cbD15+UEzKtpfmFyAJ/Wc41+6vShJHEaqxKLWAWqKFWv8kRgcklTrmwnXtQnqYBZ
e1b8NzMPnnUSWVkTkqZecrDZd+y4H1jk5VnEQMRDC0bNtFqweSWxik56Rti+OE2qwHheXejI
CsHpTdkcVfv2BdHmp51eQ+r6mLs+pOZHYokYOpXOKjcv0LJu6sAV3+VkV0LIe0wNSHA0TAoR
O5CuGclznXcndHeesuDq1isck9LyuavYwlXRzoghtMaes9F9Qh/iJHOTRFHCqliYrcmgMI5d
SBKzQVHtLGTOe1tORbXbBZS5WScaphT6RiAidlif0gN85/zsXJ3MIkEIWrQEuEG0wHkM1r+d
2XBZnvUspUgJwxygCnPiKjn4CbHI1WDoApn0gPPyZCc8G9uxZsVenmTiUtwTOlMRY0aKGHds
Q23w56aFhUd5z2mFe8EQfFI1C1JjB5TBPdCm8nBOrFBLgTsx++2Ra3xBmihM2VnacKNhcAkT
D2e5uBUiq2SANDhAbDy7BylXAqx0B1w6hF39yBbm2pEsZ3MQCPUJARipDozuME+D9YwtpwE4
t3Uv1bDDrq16XDLMYKt2+CZh0u77qyZvOIaiU4CVkwu+y9fGDG6s9eZcgZ9CjAgHEjsFAEBa
YUIm/SOJ7GWZNdPKiGHnPyZKYks+NI9ReK3p2PeDETFBl+lVM0BBunv6/PD4ePfyE1G8FQeY
YSBcsU/YofY8RITgvbr78fb82yvXz2Fi4Z8/r/6DMIog2Cn/hym4w2GZK5oKK9YfXx6e2bHj
8zN42f8/V99fnj/fv74+v7yypL5cfXv4WyudHJFncir0ED4SKEgahbh7kZljk0XYpZLES5JE
fmyNBk5X7xPlOk+7MPIsck7DUA1XP1HjUPdZttDrMFjbr4f6HAYeqfIgxL2QC7ZTQfwQdaor
8JsmS1XnVAs13FhDvQtS2nSjtVLABcx22F0EttgZ/1JPitjFBZ0Zzb5lAmcSZ5massa+nA+d
SbDzHI8oba+PHFjbgoEjytwLN+CJ7pdeA2BpWP04i5A1XwKrH28htJz9KSPH+KvbjCdr+DX1
fNQVshzfdZawiiWpNQrYucD3rYEvyNaY4e+0aRQiM1Yiq3Ufzl3sR4hExQFUs3vGU89DWny4
CTIP04Ca4M3GC61aADXBqD4y2M7dGOIeG2XTknET8BtoZUjDTLnTJpJ6wFTaOHWP0XwM4kwP
1mLMFyXD+yfnNEwhnKMtxgHg8EOlzDJHaGeVA1NVWPAQGy0ccMTGXjhi1NvthG/CbLM1O5Fc
Z5mPDbADzSyfUVqjzg2oNOrDN7b4/fserPGvPn99+G617qkrksgLfeT4JiBzkdKytJNfttLf
BcvnZ8bDVl/QzZpKYHdkksbBgaI5rScmNH6L/urtxxOTCIw6grwGvsz8NFYHockv5JGH18/3
TGB4un/+8Xr19f7xu5Ke3RlpiHoskjMqDoT3SV3eCBBJmUlTcNAovAAXnNylEsW6+3b/cse+
eWL7m7w0tbehbqhauJCt7fwPVby6bIOtq4+rMCoMmE7BAseWAALUNMKoSLM1Y4htOEBHvTsu
cIzIOMezFxB/bVE4noPE4bpuYYhxXZqFwaGbpTC4lx0Gp5HVEMdznETI+s7pa4kxGFk/OR17
CZ9g6XQV+Wx1TeUMa8syMGzWGdIgdq+cDAatLqt10gRrszRJ0Vqk6YrwfTxnWZxgn4Fi5cpn
G7QMG0dLbtJwbWodz36Yxe4uOtMkCaxZ1AybxtNNMxRg9UwCHHg8tBnvNAfyM3lw5Tj4/js5
nr31HM9eiMhNAKwVlfZe6HV5aPVGezy2no9CTdwca/M+VohHqX+BeMTmhVVB8iZAulYAuAaj
5PgQR+1K8ePrhBAzP061pEFGjcp8b5+P4ut4S3bIMS933mNfyiErr7VDD77F8N2nZjT74D7J
N3FmH1PJdRra577iZpP61kAGamJtHYyaeenlnGt+dbSS8LLtHu9evyo7oiWegQrdmgAHVheo
0scMJ1GilkHPUUgmXWWLEpMUYmL6xcdwavmjpSj6j9e3528P/+8e3oC46GJdlHD+C62aTrUT
V7GBncmzQNVtM9AsUKOaWKBmDWSlm/pOdJNlqQPkbz2uLzno+LIZAt3Q2MB0/TkLRa1pdKYg
SZzJ+6HvSv7j4Huo0rfKNOaBF2R48mMea9pZOhY5sWas2YcxxbtXoOngQPMoopkXOlIGEVpV
ibZ7X3dSquK73DMWeDcbdl9kMYWunGRJ3kuk5E2I1mWXM1nVgTVZ1tOEfYpoecj8T2TDyvdO
9rQK/NgxqKth44cjnn/PVlNbh2Lq29Dz+51zSDZ+4bOmi/Cd2GLdsloacsm0FyDrkLpAvd5f
wbP/7uX56Y19MrsI5DY6r293T1/uXr5c/eP17o0dah7e7v959ZfCKssDV8l02HrZRpP6JTnB
1WcFevY23t9L+81E9X5IEhPfZ6w/zfSBjnUhVwFgc0g1VuG0LCto6POpg1X1M+gsXP3vq7f7
F3ZyfXt5uHt0Vrrox2s99WlpzYOiMGpQ8SmpKbU0bZZFaWA2miBrK57QeDhvf6O/0hn5GES+
2YScqEda5JkNIToDAftUs74LE7N8goyfp3hV44MfOezbpx4OHIG4p0HjrQ6aYLNBxwcyknQL
f9lHmYfq8k896HlZYrYT31HRcBH8JaWk/qha3PNP5BpR+B5SCg6KnlopC8tz1AcNW7V0P+JL
jycYMTVzFgPB2bxsnJpzZqBs9zMal00iw1s6H03bLCE+ZjqztG06xyeGAT1c/cM51fRR0TGp
xFlqAEdrwAepXURBdg15PnbDQG9INs8LM5mandEzfJtcqopqPwPcjkOi7WpyKsaBToKpFsbW
pC2qLbR+gylsqXhu9Fm1TYFs1E5QOySTjXsaygpmelpktxEbvkIrc2u4wswMVUlRdEwRsD3T
VPwDauTrurEA9EMdZKF7lRG4s59hOc6Mxi58ti2D/texUIdoLncF53oLsz8zJ4hoINVWT6Fa
PSpWtdRa88lAWfbt88vb1yvCznUPn++efr9+frm/e7oalnnze863rWI4OwvJhlzgeaOZ8bGP
/cAh702472zGbc4OXb41x+p9MYQhGitUgWO9aSQ1ISaZ9ZQ5fmCWesYeQE5ZHAQY7cLaxRw+
EjlHqNPlKQ/dokPKFIkeq0o8dNPi/2ct26C+7uWsyzxzvvBlNfDo/KwOuemiwP96vwjqMMzB
0jZAxJGIy7OahqWS4NXz0+NPKUj+3tW1nqq4sLY2OVYltuqb02OB+CFWHL/LfNL3nM7lV389
vwjJx5K9ws14+0GvQt1uD0FsDUegYlfeEuwC3xwenOoa9WAMC/Hhf1rEwBovguza4eEIH1p5
72m2r7Fbyxk1d2gybJlgG2KyTpLEfztndzUGsRdjVtlSVu7Z1m+ORljkQ2sFOxz7Ew1xVQT+
Fc2PQ4Bp6fCvy7psy2nk5c/fvj0/KX5b/lG2sRcE/j9VdWDrImvaLzzkINLh7zWuc5BwAf78
/Ph69Qbvn/++f3z+fvV0/9/uSV2cmub2Yip3aQo1tvYMT2T/cvf9K7irsfTkyb7TrgP35EJ6
bNcHB/tVdzrbDkmKvrF3FUZTb9qmpzuFLO7kXu6+3V/9+eOvv1hzF+Zj1Y61dlNA9MBlfDAa
tzC5VUnK71Xf3JC+vLAjbKF9VajOdCBl9m9X1XUvjCt0ID92tywVYgFVQ/bltq70T+gtxdMC
AE0LADWtuTWhVKyBq317KVt2DMe07aYcj6pvRSCy7tMupXegpQ7+ykqdcUvy67raH/TCAh/M
k05TQ2PA8D+MPU2T2ziuf6VrD692D1tlSZYsH+YgUbKtaX21KLntXFTzsr2Z1GSSqUy23s6/
fwCpD36Aal/SMQCSIEGCJAQCRSn47It6iX6pSe5XuNn+3y/fiWCJOGxF1w16hW3la0zCbxi/
U4MusgCtLZGULdedN4Qo9N/snuadb9yEVDhOAVJ7AFHSUT4egGhOOieNzOqqwfooDMOdIcWE
FyWIj440J9jnPeXvCygQoxdpfTun+hKA3+jd+NNeq7K9drRBB/vR5jWuXMrQj1PHy4zwgNgF
dNrUl961gDlJgMxgPivCCrVpUdCzsSuuiSFJBDmS089Y47HMDFab0IRAf/MT6wbkrA+HBI0V
LPS8LobKqGtG33lfvAzUPrQSnamKtax9SoXJVX2yg11KslwNHLaACClMiGUAHGMnqezRS/q7
p9qlF5BDaoA010F/hxXiXHeAPdMBjyYsyblKxKmzD8KTqxakZwHp77BWcMJYXhrcG97eyhot
zNl5FY/ncAsY265hJ9pNfCLEWBBVm/RFClqip58v4ArJG9gkCseMf753jcFEkJ2co3ltmqxp
6JsYovs48unvX7gHdEWW147pk3TPhj4PdNUMG7/cxTXFLKGYSaQa8yuZl0KjYQPvm0oT3WsV
h+pBWYD6EaTZyd1R04830Ku0WRDLeY5oDTgNLrA7gqjy0REDF0eoUp8uTQA5qXQlygNzkeIb
CZllvsvPmInKoT2sEIuowtIKVlC/D0lLCu4VTZmdCn4xymUJHURMTFARxMooUOWgjuqmoh8X
nOQl0r85p1/aNUnGL3numETLl0ptZDjaTOhYp2JADqRxGTc8fFSjyUM+s5HjbD1BXfD1UMEP
/lNgl+SY+q6gCmVqIF6tgK1SDdzJnKUrnuGDSFAnRfciEqQ5NYpSZUu9sNBIYDdhDoYuWVWg
YqqM3UXmC5opCH7DBfk+izx7gCgjX4poJKAXxhN7HlsRiPxZTRajt1fmeQt3yh7osO+wxrg+
B8WBFguc0qf2l69vX4Szay7dJ+3YoEvteKLKoNamTYKImmszQX9q9+rHA5ugzTyf7/T0rgvV
dCTG6GDXd8ZuJTWF4aZcnoQTDLZJnZc4q9w4DlOmIvmWBDLCQcl3weF6yF53xgY0XQ3fHf65
eXxgiC/plC+fE4R8241IcUFcvTKoO6dMJ/bLx9++fP7064+n/3kCPT8/ObcuzYCDK0kiVjAG
R1A7j7j5RRAx/MtpRq9ADWK/UMg3U44NZyV77jM/VPbbFdO+KpvlCp6inxMFzBDoK0bmFynz
jELOIeh/J3uRYQApam8yaFQDntIHIsaSUlCGH9ysHP1ygl1Cj7FAUpY7haSNQz0SjIY7OD40
rkRzZJbtITCiJa4YEUqaZv4Ko34oqTgWK1GaRd7uQFUMd94bq2tKouX01nROZLe9MObycG/F
bUo5cwvPKNquMO0kkznu65/fvrw9/evzn398+WU2XtkLT1rA4AdvVJ8mDYy75lDV/Kd4R+O7
5pX/5IeKvoKzJezEpxN+L5VEtClvm8tFOzRnTV74eyyLeoCrHJyfCGEpFPLqT5dm5dD7Pu2H
YVn41hp4M9SZtd1diswe34tqM4MfMCN62DbvcPro8vrca/H0Ad8lr0R3hov6OhGrmXLvLVb4
P94+oq0febAsRkif7PucXfQ6EtYNN6N9CRxPJ3IFCoK2LanDtMANXa6fckWX8/KZfOOKSHbB
uGP6GLFLAb/uZj2sGei4yBfxGpMlZWlWJPxuzC6yewsHFuoWilgQwbmpOyOl6wo1xkYpmVcc
kPoYY6QZkf1DhX14zu+mOKu06DKT0/OJ3PIEqmy6ohm4Xs+1gEtfVpgjB+2JsG5OoT7f6TsI
4l6Tsm9aJ/pa5K+8qckbtWD03ol0tLpkCgxKYID6XO/Mz0naJTqofy3qi5p4Xfau5gWsJbON
konsxjqx1MMaoG6ujTlioCQKXDHObgsjQgUCcA9cBQPXkXl4JfYuk/Fo3HS5nGnmTKgK1jWY
INFVGxzU8i631kw1lH1hyV4hqPtC5wDucPmz2TycOzHTJcw5KleBoMj7pLzXN72yFpOZMWte
T2A4RjoHbybZMrMJujLBI2qNea6NvmNoCJEFW5eBTtMVVUJfsBHNE5gFzxtoEQrBjccQE448
3QLf50mlT1oA5SUH3Z5zc9SgqbYcXHqrq6xlf8YgjgkvElfzVdL1Pzd3rHWVmwpFfaax1xfX
xuQLtAPPyRykAnuBtVmZrPWXbuB9lXA6ZBeSDLgZji0P9Cn1WhRVY6qKW1FXjc7ph7xrRMcW
6AyRndLY+XDPYONzrlWZo328DKkhLAmXVrTpl7HHlpPNbPZIJzZq6R/gM/oEgfF/xLpUdpYV
Np6bJituahNmTWahKS6XknS64BdH2yK5D6BHeQAxMkib5eSHyip74ieJ4EuFy2gDegQ0Vkge
u8jiM5LqFsY1bS6swOAgPRxG5Te+VU6IzxGfwg+JNPKfUxRZzjWTItIQgZ4WfFWRebzgSNAX
TFOnM8yVMe3t92/f/+I/Pn/8jQ47NZUeao6Rg+AgM1Rkzhbeds2Ylo1ofQFOkN/txi7f/vyB
B/L5U3220XhfnCqobKPH489ix6rHINacrSdsFx7VrBMLGE6PmCATk/kther8FXdtZSHjL3nb
1+wEC3QUGyspJ4VIbI0i16abMu1w66lzNMW9wrkU48LZJ39MwEzIStSQ1MHOD4+0k4WkAF1P
R1yR6Fd/R7qbSgZZFQV6CP8VTr5rE2iR7kSxDqxA3wZGewp4VN8HCugUY9pkRaTtJQ3jUhhN
CkIfX4Y0N+rDONGh/jBNhbuDUgoqR1x+yT9m/dmbnQJgaPW0DbXkCTMwFLHHhVnXZA+xpK/Y
ig2ICiO76ThUIxfPwENsi7u0LELEkIX0OWchiIINAmnicvVqMnMZ8nutDMiaIsSar5kfkx6+
snt9EB7NQVttZNoklGHfrQZq7qy9zvtbqoaBE9CeJRhR2KqoL1l49BwfZSQLMq7+1toL/2vV
2/Q++b1JVkllWBOYggfeqQw8RxIilcb4kmSoLuG1979fPn/97e/eP55gv3vqzunTlFv+P1/R
cEwcXp7+vp7x/qHYc4VM8eRrTgGRqi82hVbeYGoYQEzpYspE5OByLjzUSvSHLVl6CkG9MVCt
7p2svHJEA3r/7fvHXw1tv4xi//3zp0/UDtDDHnI2gmUtpVIccKtIat4Z1uMTYzmmnrW+cU/4
HM6xI6wwjJXJWaceWAXK+kqHacDRw0kDyL1Vy/MMZ0fWN/xObfqIBUwPxzC9ngk42+T/9v3H
x93fVAIzLRCA6iu64UznUwA8fZ5dCrWhRVI4np6wjZOLKUGAIWv/oqDjUMBxEY4BOhqjBGMI
rvmQhOdp5MOyq83EMl+QGshzQiRpGn7IeWDXn6R58+FIlbjFu5tNn3YMjkipjcg4fsy1K5Lw
keV1P3R3U5QzxYGK7aAQRAefKnq5V3EY0Y4NM41txzcIMEO88dRHQZnZT2gaOsmSRkGMzZy/
xB5NmejRKtDxkAX6o68ZVfDS83f09wqdhnRNNkgiu+0bwEOq5Zad4pD0UtYoML2SVanABE5M
RMxYgYiJEtXe62NajALjyP+9zOwlB5WJeAn8Z4LBOdOi1dxWQH6V5Kg/fliELDNabEoSaSIy
EstMweEIfdwl9vidqsDT8jzNVcKC92h4GHvEFAV63V1+xuQV3DTIjBVz0Wuw01PYqRjywchK
EMe7gBIyD8lcJzM2Ay0Uz5oUn+M7NSmaJ5IabWbLRyykx33X1sCENoOrx1YPYP76RowrbVyO
jHb0XMcdXytae3j75ZcfcHD6/T3+WNXQviaKtvXJTJEKQaglf1PgISkaVOBxOJ6Sqiips4JC
d1CveCvc3+/2xJ5jfNNW4RE9Sfpn79Anm9p6H/eUSkZ4EFJqJ+7DIzWZK15FvuMd9qpc9vR1
YxF3G7IdMdo4VXY2l5gK5kacAHibJx3F5PwRfoOFD/f6pWrntfPt6z9ZO2wfRBJeHf2IUCZT
0GRykhTnDSPIor14OZ76akzKpHPkJJpHH9NIbMlZpJm4wk+bTfRYIadPQBnXFr3XHoMbcWa6
dnuPgif90etgoHaEHBHHk+poY9YPrhZ71z6mXQUX/jHeLjFphvpGgKsr1QiMe5IlQUzfXhY1
Y4f6NiXZw/929BaIqZe3RDflu7fk9vOHPcbSsnpStsLyQyLwNkouDJHUe7OTIj3I9iS8ORKd
rvjxurX8eX0lzxhVc0voUP8zQe8fPEKXTmnTCfgh8slD9g1n3JaGOgSUghKhv8ldrs88l5Vg
VSBtTtg3hS1exiba1D+LX+zqRwKTVma7oWBKGgYbd6Xt40BhP2tK+L1mY38b8zpJ0WHlktTC
Ue616JnODpCctedPCFtyzMpyOrPagxW0T3cJ7DFnwKjDnFSMjW3L9vsdDOKYIJ+28JJbgVUq
ui9l1chTTAFTaMHosWFcV44YdyIJQeJ5N/KxNyJ1nZO9Em1LzYlAxTcVNH2uQS4FL3SaojqP
VcZGOQQzUH4rAli0V0U6wZvWGpOF5DkY6eGq2MlgBo4yaZ4MPTo7JYyA3wx41Y6tXgNAeh0C
i63Rdunqxh0c1Wl7mgZSLdCyi1lgxZU3J24K1P8ethqoW41EV1pfeNtlJnOTAV4In6hGqFN/
NyZtqotZIrydENwqaEz7MRqzf85XJrihGlkIbvoUFFrOZFgG1J8OQGPWusan6p/HC3dMHcCx
F41x4XF5wRk6VueqpxDagkFOjYQjE1RbqBNhy2hHYsDnrg5MOCxLxsI/ybm7Kvkpe4MpYDH5
8jFNOLljiGD52rKYK8LPmjqmL4wVJzSgPJitJCJ9Qtdw0FydvdhLo7+L4mZfPr99/aFdkBbV
TYsRoJMtzlLhUmX+tdSeDic7rZCo/VToryD4q4BT01TWY2xJmM6paq759E7WpZBF1ifH27wJ
zfPyhP3hRAuXPGnp+LxG55bNZLjNCVAWacEO1qHDzeqEkO1xEyFs5hOGYBbjhKt2MPl7FIbj
3X+DQ2wgshx58NXtIeGsKEbp+jO313vRs/4IHfA+Zbttk06kdGvR3X3lQ/yckT/tDHDXCDkr
bqgSIb/a4sWDJ2dqfUxjNqYlbPWa7FUM7UOkUFgfnVUu1k4M6psm+DEyNckNAtrpvlF0Lzoi
w9QbFCLJmQ7gecca1XNG1MuK5RqjIfADmA4Rp4AyxcR/+ksECykKh15InaZFo92gvuRBUHXS
Q6qejOwOJ2SpKWDCDuSYC4IKzok0Fs5yG/lJEK06f8jfYmyM6KMCXuX1QBFrDCtV5OeEUbaW
iSbFrFKqn+IEL+p26C3o5KZiNoTg+Rk/lUxypc9aSqdeLw2GxNZ7JmBCpc8uMLIvs4KtPn/8
/u3Pb//+8XT564+37/+8Pn0SCeH+VFx8loDa26Rzm+cuv6eD5sPB+wRUO+1QN98uHOuwa6p8
eSdCu6aUZVI3t4VIOQGK74/jpenbUv0eNcF1KTRwe4UDIx3T/pLANsFKxecGfuC3JhD786A8
sZkJYYHkoNHUlJ9CU0+VyK3yy7fFG0h8pkUjTPf277fvb18/vj396+3Pz5/0TIEF49QtFdvj
bTzd/mcn/MdqV8a6FMcuyqlx5X39yqIm/tTQx70jtYBC5kolrZBcish4TaIgOXM8oNNoyCd+
KkURBnuPEpFAhZ6r9SJ0BHbXifbUdzidRH3Lo2DSyotjzZijIFnG8sOOMiobREc/JDvHRCiZ
kbWO/gmzYJnf+HsDiIQ8KRx8nvOqqN+pYUrXRlcwpfJ2zPj+tYx2qn1KrRbucvAXU3iqK3Z8
abriRQeV3Nv5sYjxnxVnsjZxmyEx9mcrFUnmi1cImlvtLHxl7y4iuPL6o8iitN1Mmh28WDXw
qRKU6VE1x0kxgCLnps4ccvwKAqetogv6oFpgF+jRhKZJ8YzZcz0D3HsjY4OIYEUisuJqcpWy
yj943phdyUzFE0UchEaNcMyJAt1eqcLHc9LTzwBmquempnZiZXwLjHBANcDu53qg9/eZ5OII
UjLja77RXfSMotrllF+2UMmwFFN8tKM+YdX0MSjEiF2DHb3kBP7oKhpFzlKYZYBeA4A8HGN2
pT2o9L3C177f4MNlYeFSTCj9kOrEyvFkQSGj76wmOFGpRz00OstNXRvrorrFFbn+Z6ShmgRM
uY4vsJefFq/uT29fP3984t8YETsezldwhQBezosnlXaDX7HSrk+wZhL5YbpVhyOXhUlG3kVV
opunBTbTURhKzUL1oAfmMV9c14nBIcT3nKPzUp1rdg9+x2hKm2czETasf/sNG1gHXdXG+CZN
vrEhkL1/2HmOaS6RoIRpNyybEm7iQLrREFrZmSTZaPBSnIwWN4jz/vIoe2nWvsMebFrvUJyD
TQrP30CtDLj6AzRyDB/pPBD/3J7lgL7ff6CuTmd2Om83/6CwgfJ9USJRXj/CXnSI6BOhRMnD
hHvcBQ1mr92mOMPFdYNhQfNQ/wXlMtk3aruKvJsPyVO2fnpM+JK4aItd8ii7gjp9Z4SQyEse
IXqkJj95f7iRLH2oD4fjRlWHoy25DdpHF5kkbvPHieUsfJD4+vjkQGp7LW0Nh1jsjwzrqvVc
1ZHO5RqN+VXZQj6opwWp1P/b1UmeH6jOPWsQSbC1QWxvTBRp7AWhs9HYi2hHU4vqwS4K0s2N
V1Asut9NsaE+BcGq8GmSQ7CBWqp3ddjhCqlThZ6R2M5lU9JORcrBabIJSrvT71++fYKT2R+T
T50W6PQRcuXLIO+TDv5lgQc9hSsiITXx1e+ccUaO0ov2bF/QJmFg5PeT4INRv44Wl+SWcfRL
i4/meJGUPLuF9KV+oeNVNnYtdW1YSACtPC5P2hfYb9kY72Itoy3Cq2pCUOdvwCct52ZqwwUe
7TzKQFdM7e136l1vhmIhGxrvopsOLUmopFWTG8LYSmgUaa7IC/xIZjhY0WpK5BWq+tIhtLSh
maQ9Rl6oQ0sbCjXIobYqls2ZPZqID3u6S0dKXgo6MotN9R23h+IYW821w4RxFJwrjvXFwacZ
QPHJGW7NgJ6yN69g/KZJwc8rcL2QT2Df4SYz4UGbkZHtAV22iYgL1+Vkm6LnRKsVFEIwXakI
0mPXB7NC9jnehzpYrAl96iJYjGvkeNgnygn+aFMEjn8/dHAVRhGYknmJOFxvW5d0Jp5sRuVU
0DObI2LuckymyUSKSa5EWSEDu6xCcxPchGTVa81a4rV5PnsU0NeTRc7ggEwvva4Aqy4JNttd
xsKkXxB6ibYqxhZfbIHaRqul4Zhy0oL0P6PSvTHNB0UY0U/TQEJDWL/Leic9P3STUl7lV18H
dR8Sw+DaHTAHgm6CQ3CcHIKE/IAxYaVvqFXoQOauX7GB0bwAhnRNDgvTSpC4Pg5IdGr2VUCZ
g+98s7JDTNRlXJZm8NEpJoH16EKb43bcE80fQwoY7Uioo1UyKeuKPtCDdXRo5pXg+C7BdsOJ
2QuAROddYExofoFpapKiZxRrz/oLyAVzzmsf0TQqmFA6x4gceArlMNACOvxsL0TRPOwmndGI
hu1bGgvKIiJPr1NgGs12HbBov7xaRypa14btFX3+3iHLb/e64WMAiuZB0v2DdOHjVYZ+9DDp
/uE+hXvfRaoTJl0Vqb1aJTETDCLmLMiD6Ub2CQ+YZqC+0wuPTY1hQ5KYDmybR0G0D0j2xAwp
TsU1N6evhI5t53BmFO6l7wyjqAefNlBcIRy/zimfW4a6uI4nD1NOcQsV7ooxwVEW8JWPCePh
12k20C0tFJ2j+CUyC9sUnkVj1dFZXO9Fw1Srhbu2CAoFHlEoBoQfuAsiPggsJhAcBz0Fv5DU
18AefwBnuU+Bu/3OAh+xSarfSO/ogKK1+gKDOuj3TITPzsPO6VaeK/wKRNQ+uRJfgSPV9fGV
t0WNClotopgl+Lf/fP9IJN/oiwqjEysPAiSk7Ro1nwTwxDtmfC2fPi3LEur4zB+IJYbs5PSA
a4tifsdl08wUr8LF22r+1PdVt4Pp6q68uLW4dbgJxKuuyNk0fti32u2yrR7LVeSqUC6lC58r
nYWBHuujAZTPs+z265ZVB6pXsxDlW6qx75lZ5fTQzq5zEnyW3rBJUKMOF8Y5/YqzcXyBYHMM
s7bLt+RUixEQIajbDbqJzbbgfcIujig6E5F8ZUCGxIUN8HqoRJSHQg0zJcMst3oaHgl0uaWJ
luShZQqyvM7P6e2hc3Khc8zYtdyUEj4BMEBi/zJgU+s/ow1gYnqmvkzLm1VaVxZ41Q/kK7Lp
eNbA2BG19ZWmHvOpazA2Dle1SVo3Mo5fHODkrjrl1rHA1PSiE7DV2pYNYyYqkVepd/h8yHmA
z/Z0ibL/p+xJlhvHkf0Vx5xmDv1KIrUe+gCRlMQyNxOUrKqLwmOrqxRhW/W8RHTP179MACSR
YEI971IuZSaxI5EJ5ALDNR4xnKNbj+YZ3l3JLQJqLSUfUa0lKdklo6KLwdKtcMZmExKOnGXh
3YcizVZ2GhrsfE4grX3oMd/urAtU5YB5DJFl1PewHtVHtqMdHCeqRYhgu9Q6j/nw2qpkgO+w
aI7itNV0Rwcs6aD6XhqvktPK8TWr4mjQcr3FgZSNYYeONHl851SsBZZcbnRZ9v6ihKotWLY1
5GjaDe1LXVAfnUYnWTu9YvrMG20KXj38OH2onJlyEKdQfY022JsGHQDdcnuM5lnk3cND0vlq
sA8cf9c0Wj+TlqJFrMUuQ0cHKZttXe42nAdBudbkfbeQJ1aC8hF00jkOrObdxdkW5Eq6fnN7
GS5RpLv3lq0IROW2ERdOC9LBfE4vl4/Tr7fLIxspIcGwnmgFxw4487Eu9NfL+w/GJbWCpdm3
Rf1UzhoujJouaph+GcIYTJ43Fk3WuRL0jSSN6cYHw4Xfp3WXKxFY0+vT/fntZHmyagR0/p/y
r/eP08tN+XoT/Tz/+tfNO0bd+gPWGhOREQWrKj/GMPdpMYww1T6RyQsbnEL74kei2AveYF52
JktC7mqiLWrkBg6OMkqLNS9CdER8Gx26JPHQEaq8q9Ieea6negi0S7NnBDQWDzY8/LirGotC
FmVJLKENrgrE4GuXhh2ltu3DJvaS1HKM3x7TmJ68BizX9WDSV2+Xh6fHy4vTZ0cL0aGxbT4A
xamokWyoRoXtglAR1aXKV2y32HaoFhaH6sv67XR6f3wAlnl3eUvv+Mbe7dIoGnhs4527zMp7
ClkL+wTc2edNXAkRtIkIfrfC2P5dQ1Rrz/+TH3zrB4WHTRXtg+srV80gmmjaS3ZQrrbdBFXr
zz+99WlF7C7fsOKWxhYV6SRToioyeVUnVnb+OOl2rD7Pzxjmr2M4XEzTtEnUBsThNKlh2Nn/
70s3kWh7+4DhOmhlEPIw2WAI3T1IOR6hBfZbLRz7OoSrl5b7WvAh7ZFCRpXPBqVH/w2vam4t
Cws7o6zbSdX9u8+HZ9gqnj2rxTl0zdIBYRxzADhjMXBSzCWZ1UcZCNIgzjjvShu5Sh1Qltnb
RoGUFcEAVMXOl8YewR5rneAmKqT0c0cjqPJLiB0UyrCMpnVN4NnU1m2NJQbpuSOHf4v8273c
X6+3Opy58JUqUMsAjqXaiUAMuK+HuRzuYqVi3otqsM2s1rQO/PsyazDrIkPvUocDakuyRyJL
NN+pu4zuEFLr9XB+Pr8OuZSZOA7bBUD/r0ScvoM4Rsl+XSd37EV8E6mbdc3Q/vx4vLwamWqY
ZEwTHwUoQF9FZIWWM4i1FMvJYmTPkoKrbEEucS4OYTidcvD5fGbHqrURiwmLMGEKrRWgMNpn
yNvtY9UU0/F02GC9IfFROU9t6yaDrpvFch6KAVzm0+koGLQPQwS4CZN6FCwV+DcMuHfMHCR6
GnvS3AFh6kk+QI8mSFb8RYgRQOA8d1N2twTN+JjBSd9wkhzeLid5Shy8MdoBgDidC7WpTZWT
G48O6PXzz/eAwBW7IgmaQV3D66UiaY6R5e2N8HRNqtCOEMci4QPK4/FD8wWqrJPHOK75Xrd3
UXUVpRYj1Cr/Oo8CHG1yGWBu4dj6U3srpOjQrJI8Wfp2BztGK47UCRpD4EbQ47AYfR3kt11u
xwRG/K3Kco0xGwjYBN0Fydu0kGD1f9eS/YZ2pq1VqqyILUlgk8h7JmudQZgP+KG0Wpnsk6KL
OCseH0/Pp7fLy+mDcDARHzIdh5QCaJ7jVS4mo5H726WJgHOY/LwslNLHIrAtmWIR2qEIYerq
eETMzTSIi5SpMHbESyuRhq45jOm8yKZFiEMqPTgMH9niu1bcHmS8ZDnF7SH6ejvmA+vnURjY
oTpBvJpPbF5vAHSIEDib0c8WkymJxQWg5XTK5wvWON7oNj9EMIWcGQRgZsGUWlQ1t4twzHsE
Im4lpiNW3nKWnV6Krw+gWN98XG6ezj/OHw/PN3DEwrn64SrS8Xy0HNdcEwEVLMf2op3PRjP3
N/BBESUY3EOATpER9HJJritFnCq/XcGmcTQKNyCtMlBfHkKA1YlpHDiYQxWMDkPYYkFhqPoq
p00KjvAde9TW1p+YxT7JygrjNTQqR+gVswK7OHwHymqUWQgYD478EEwpdHvQCQ8Hd+jOSNnq
6zz2YnUIZ88wZ1WEvsJuP01kP3+ZTRRM5mx2BMQsyEpWINbXAYSmMYlfjOEEZrTzeVSFEzbq
cuuBh74U0zka9h/ooKuLJilqp3N5FaDXAT8ghdjBwU22O74wekdCS3cgTfDFKSFujxNvfDSp
vqXDJB4PJWl4L/mlTtN7zP5KfYoA8Ha8VWXt9K0u3ZmuC4yFPFgeQ21KjyOnjaigqW65KmSq
t1SplusxL2OtHHHFKtFGj1yd/D545/A0RsdaWysjXRLzy8a4bW1yFeuPDaumRnK0GJMvFFTC
wcNxSkTmoFYMxmS/nqkwbPyYGBuHwwDf8vVrPNzm8uu3y+vHTfL6RO+c4JitExkJTxLP4cfm
7vnXM+h0zjmxzaNJMOXL6T/QX/w8vZwfobU69CQ9bpoM9k61NYIDdwwoiuR7OUjLtcqT2WLk
/qaHeRTJhS3hpOKOLooqx/AFJNixjOJwpNYOv3IxS2GdImPZOGkmrLUvQ06T2n9fmCOwfeJ0
x0bH6Tw/tXE6YdJuosvLy+WV5gE1gpaWbClfcdCtqGvVypdvi2O5NEVIM576WUNW7Xddm/oL
gQHSke9ogTzOTI4OBWcWOaz3B700icjSCRHT0czyt4Dfob0q4PdkQqSU6XQZ1CrGngMNawLQ
MW+s38uZI0xXJSaGplEE5WTiJqJ1TtpY8Ns/nwVhyIt7cCpO2SzJiFgE1gKHwxLd+Adcz47V
2IEGjBUjAopoOmUPds282v62Ie2uTZK+CIcV9vT58tJmBbZee3Hu07zKEp2HeKB2WTitWHGX
KAPKTpXtb87dJuh8MG+n//08vT7+dSP/ev34eXo//wcT4cSx/FJlWfuUp40Q1DPxw8fl7Ut8
fv94O//7E0P4Df3aPHQ6xPzPh/fTbxmQnZ5ussvl180/oZ5/3fzRtePdaodd9v/3yz6f+9Ue
kl3246+3y/vj5dcJxrZl0x1j3YxnhNHib7oX1gchA5CYeRiltRiUEkhCEjA3r3bhaKqK9812
Y75j1UiFsrXIFt1swsDkKXEW77Dvmg2fHp4/flrHVgt9+7ipHz5ON/nl9fzhnmjrZML74uBV
42hsa/QGEhDezBVvIe0W6fZ8vpyfzh9/WfPWNyYPwjHvixNvGzbQ0jZGxcdO/xpHwcij5293
eRqnjZ0EuZGBzY/0bzP/vfTQ7NjMajKFw5gqwQAJeDV30HETMwWYDya3ejk9vH++nV5OIM18
wkCSgVnlqVnCTCvWh1Iu5vZEtRC6jm/zw8xR0/bHNMonwWzkXb9AAit8plY4uYSzEcwJmcl8
FsuDD37tm2MaEp59ZYh0PiuVz37ABkT8FSaeXBiJeHcYj+zcbSILyWKB37DraITtKpbLkI3w
o1BL6j8n5DwM2KW62o7n1P8LIT4/FTjzxgvW4SfHlCOWzAiiu53ZD37PRlP6eza1RmFTBaIa
2VfuGgL9Ho3WZIHcyRnsBpGxD1KtfCSzYKn9aonQ2eMCPk+RQo5dqXy4a/nqLYKqtm3Bvkox
Dkgs/KoeTe1NnjU1zXC4hzUwiSzmC5wOuKLD+xCyJHp2KcbhiG9/WTWwZvgrtwoaGIxcdMdB
xuOQCvgA8XkoNrdhOGadB5vjbp9KKloZkMvemkiGkzF3BiiMffPbTmwDczelSVcUaMFdbCJm
TvNYAWgyDfnh2cnpeBHELG4fFRlODCfvKZSds2Wf5NlsZF+pasicbMJ9Nht7NuF3mEWYqTHL
zynb0dYEDz9eTx/6IpNhSLfU1Vr9ntq/R8slvUsyN+O52BQug7aE7U04ZteAtUWwhKQp86RJ
aleAyaNwGkw8sbI0Z1YNUAKKV8fEVQFa9nQxCT1nSUtV5yERKyjcXZzfRC62Av7Iqau9tuYN
3Kjr+fh8/jj/ej796ZqzoMq4O/Cl2d+YI/rx+fzqm1VbfS2iLC3sQR7S6BebY13qBPH0nGPq
US1oczze/Hbz/vHw+gSKy+uJKiZogl/Xu6qxFGgyh9qa3liC+0muEWDGQ04/55tnzuZXEBBV
Nq2H1x+fz/D/X5f3M2oZw6FUx83kWJXkMWWY8FxHe8fcn/zN0H9TKVEmfl0+QKY49w9f1p3/
NJhzd7mxHOvMZJZmO6EZUFC35YNUIAa4H2GIVYaiNdsfTzPZLsAEfFhDmuXVcjzi1Qj6idb5
3k7vKGIxzGtVjWajfEO5UxWwoQjibAts1toAcQWCGC+TV3ViB+reVvR2K42qMWoh3ChW2ZjE
uVC/Xf4BUGCP/PGZy+ls7HkWA1TIR+gxPFE1nCVopnAOcfy4CkYzS+z9XgmQ5GYDQNeFVp92
Z6UXe1/Prz+IJmUfTgRp5vfy5/kFlRDcHE9n3K6PzGwr0UzLSJYJXixqZYjH5zDKV+OAboDK
F1K7Xsfonc+VIuv1yDoj5WFJFg78ntLknfgBt8dQHAi1rG8d9dMwGx2GR2k30FeHx1iTv1+e
MbyQ/22yMx2/Sqk5++nlF97AsHtO8cORAJaeUPs7a/sgil/A2WE5mnnCQGskm7iwyUE3sNak
+k3MhBo4CFjRVSGCmBwNTP9a8oLa9MJP2HW8BQ7i0ph32EFcUnG2NIjRqZiahPAERODirMqC
M6ZBdFOWVnxf9UFSr91CmloUEl1HeGE1T46rHae8aFez/oc+W+3RQKDP2AdxymKJbLYWCEI7
Z5GJ+O7t2K2JixXsEqD5tq/cpM7SgvaIsdpGcOuB6K0pvudkR8SYhHsvNsw46dGqt+lq31BQ
mm9cwGFMiwIIzdNpgHA086kHFV4nntlcodCb2NOnrAqXtnGehumLdxk5nWjT1zltzFSYLI/n
fE9gvMs8DVFvz7QdytI5lZU7he0ztq+kw2AhK/u1OPc7hiJRFYnlbOFbYtVB0NbhA7FbT2t0
1lScv5CiMK/Dzu5z7WoVUEcqIJXCsbiIqix2oCbbJgHVsQNpUre5SuL2jscVB1iDrpJBiei9
7C1xkMDQxqVJJJxhAdi2drxiET5MPKn1pPru5vHn+ZeVm6M9yOo7OugCdi1NavlVucGK1POo
byYWtluEpQHzvk4HFTId7YwSv4uxorEME83Mqiosz245WaBOWltB+e0gzxoxqH+70G3l5cf6
rs9LJtI48TiiAusBUtkkPq9rJCgaPkmbMerBuqIyX6WFbWCIuWA2aGuC+eMqOhEE5zuPgbNj
0awQNVgG3bhVIro96swrrQZRCnSMBuYV0BuBOoUlklZl1AjLJkuHTYcfxgPEMrBXGNFs58sB
8CDHI5rzU8GV0xEbNczgnUPNQM2x9sKCjcGC+xFmLXFhaANlc3IDVefJ5t6zupHkNhjzdzUa
nYmiSe+uEejj5QqFN5duj9WRmI+iXg0HFs2PvF93vv/ueHTOJiyiiiMXjilW3GnQD6sDSuSk
eTWezoeNlWW0rjYcVzR4J1muAnYR2d362209nNhuw2+yHW+ooekw+SB36a+jlbR5A0InaJ+D
RoftAXuutt9u5Oe/35UPRM+bTWauI6D7blpAFZoZFHgbjeBWSkE7/bIh9wKI9qWRRZzx4e7K
fXGQ6BeM1v1umcatcxwIFeqKP+cGdOEgzSFDLA4bXzZESqRajZRHUYisHPTbocT+eco0To/Y
xC0dWp16Q9VCx0bnx8AvXGdIFcdFxf+6WuGxULkXA7fVPYq7t0CKQgZtg8iXCFfZHOvYV22N
rRaNoJ1UYN2TYQ9VTXRM2qgoZV1rk3UGaVYpaWCLk7D5eOnHJhLZvqQVK18JleZi2No8PQC3
9mwQEzcBP3qhcBVtgYHjAYKH9WBPqFS4aVGU7ORpjn/c14cAg79cW+yGtAbJxd1BrWSm833P
p8rLJttJvMse9E2fjdysasSgc9o/BcqFFu4am3Hb2IUKEzfoPsj+x2BRgGIn7RSCBKUGxpl6
RALct6fzKjQNpTsY4ViTn2VggBf/PkP0ztHmDfggnc8GFNs45wKYtWi91uy0MYgpoyQr0Sqt
ju2M14hSIpHLMRBh4mPcYaDkK6OkT19YU4NlpzB3bOb2Hm3WqwtHjiGLSh7XSd6Ux72PZivV
7PpKGIxx2ymM3XylU7VQQRYG+7kPscgdP51lcax+sSmwCZ3asTihTi0ED5M55B29S+iAEXao
5luVOLvBCP1xpSO+uqNj0GoNKQLvSmwdRf0nYuuutVtLd5w61LUzupOHPHzIpQnpKHSo4SHZ
q1bbKHWHAG03UVsfh+MRDoR3E/eEE0PoiClNup2M5kNOp9V2AMOPiDZa6d/j5eRYBTu3Ydqd
zlmyhELks+nE7HFPo7/Og3FyvE+/9/WqqxejMVE+DkJslVaJM7BaAblNknwlYB3keeROL6Xw
b7LuakydaSVXDSK5Kkgibv6mngizXckYXIJcY6RxlkBlX5OIRNKKfXd6Ob071YLz6Q3j/Kun
gBdt40bSj/Yn5zHOoxmc+ZUb0qZt9ZWSLEWAdb6FgbYi7OKvNrzP8b5OG3IVpLG5OLpxhIzV
/dPb5fxE2l7EdZnGbKNb8rbqWFhRlop9nuTOz+4ymwDVbUU6oEVwGZWNlVjMuKIm651MXPJW
60gwYg+5mKJ4KJC72Fc06Nukq3QiNKgamc/0UbY2NdKuoueKjIV1RHUMWneAi9R1rXUoAbet
o1UpxoLpZq1WdMyuHS1nPLQRtCqPe7JrI9uwYy2LvYQB3VREnTXeM4Ox6gkwFpcfrcuu4Z/B
wtze33y8PTyqV0v3ChFD2tkW4Wj01WBiYyIS9giMlNFQRGu0bYFkuaujhIRoGWK3cAw0q0Sw
EXN7snVTC8cXVzG5ZstuK6azbaF4IWE5ccOvY76p26sKPwaDvxJTRB33rapBJBo4iLhlGOJo
b+3EDomcuG1WV7zCruo0ds0wbHy85rzDScF5pYu2vAzJuQ0/j0WinJ2PRRmzvQCSXChdhYZN
sBDbHRH1LYzAFNTcAyKhMXlgLZTUuVpIkXKVoGc4bxeQcG3Pd1mTVllyUPeZrt0SGz9rh55a
m/ky4PRZxNJBQEiX03to5jSI/lQBB6os/iNTEmsPfuEtbltJv2WyNOefO5VxEvy/cI5hG44n
wd98qhlxiQlRQm8xRvpk79B2SOgGIzChNgsaapPYSwGSn9D0mNwlHGfFwKF3OxHHCblc78NH
NhHo+qJqduyuzEtpMa9c5UiH5U+seGi4Ee0icn4+3WiZyDIj2As03WiAQ0n0c5b2EAAoRRHR
ibIRAIJ9VGjCox2+wADQZCuFNRlZN98tSibRrkabexszOa6d2DMAghPjuC5rVT9f+cRf1+RK
XUpOGlR3C2dnoyQkrqtfV7EVyB9/dcX0Q5evIhFtyX1zCsMLGNq9DgzEER+93PryeBANGxH1
a1uw9dsejf4xzRoLTzmDMVHfoFEiBtXlRuTg1I6/TeDM435iF4WYu13Z8OYEB7vVXgqPSQWi
ygK0gwS4b73jdA8kuRd14bbIZ00BEnRAFvWqGc5gC+Nb7hKpaTZRkfVyHBZU7/D+DJbgt+Ea
dKgHLXfwQsLS4aSTvrJkfdwndbq2tkaRZm7P14HuOAXgqnCGwxAOVyql0OOw5vumy1BhSLWC
lrKPTm1VeDGIFnepndu4RWbfS6552XfOqL3FfpdNzBZV209I38siaUfFOulRDWIlBp4/4S6x
N08LOa5Uuo6ysqP2pKCzIji1TRIw1hp6nn9z8XajkiKqv1XuSNoUuAoa/goyLsoGVgj/1qxx
yKM98y2ufO1nBgoD0l2jLuTUQY7xODglDCmjxhpVsWvKtZyQBathhE+t1bli0USOWqbjqfIn
XgnjlYlvpMAeBvsqTmuUOuCPPRUcicjuBSgl6zLLSv591/oqLeKEW18WSZ7AeJTVt1ZojB4e
f56InLiW6nhi1Q9Drcnj30Ct/BLvYyVB9AJEP/2yXOKjBTtGu3jdsoe2cL5AbbBcyi9r0XxJ
DvgvCFa0ym45uSwnl/Al34B9R2193YY4xsy7ldgkv0/COYdPSwzPK5Pm93+c3y+LxXT52/gf
9rruSXfNmrM0VT050t3tqeHz44+FVXjRrN0u9fLdtXHS91Lvp8+ny80f/JSpEDHscCkMCKFZ
XCcWL71N6sLuhHOLo//0B2N7pTVshC3uykixKwzVn+RcY2Dr35f1rU1lHVEZ/dEOKT9VSNDO
9nEScv7nhGQeznumQDHzKa23wyymJN2Ug+PEVodk6qlyoYwTWMzsSpUzzg7XIQl8VdqBbBwM
ydvn4DiTGYdk5u3L0oNZhr5vlnaoQecbX9eWE189C9sDCzHA2nAlHRfeQR4HbuAqD5VvLoSM
0tQtvq33/yo7luW2kdx9v8KV025VJms7jic55NAkWyIjvsyHZfvCUmzFViW2XLI8M9mvXwDN
JvsBKjOHGUcA2E80GkCj0fz1A5Niiqs0/r3dVQ2e6OcHnvrcnXCNmFpGGv+Jr+bk/VSBEyHp
FskUiy2K5GNX2T0gWGu3IhMhekpF7o46IkKZNhOnuyMJaCJtxbtxBqKqAHNJ8KrWQHRdJWn6
i+rmQjokLkEl5cIdUEQk0BlQDA+WnuRtwlkH1kAl/Fg1bbVIau5xAKTADdHyReNq8ABdXlSZ
SJMbuvE2vG9gOjMsx4XK3bK+fd3hTYztM97bMlSDhbTfj8bfoGVdtBK9JK7Co/c8WdVg2cK0
Ij0+Tmr7H5TeLCMqjfkewF0Ug54uK+qF24KOtN8kVEjeL94b5F2UyZrCvZoqCVmnck9pqTRg
LqACrpzNtqsKKg1JM89gtGOZlvw7TL06MrZDGOeTaZ19foM5Qe62fz69/bl6XL39sV3dPW+e
3r6svq2hnM3d283Tfn2Ps/L26/O3N2qiFuvd0/rH0cNqd7emC0fjhPUZth+3u59Hm6cN3uHf
/G/VZyLRakXYxaImvb27FHiHMsFnKRowBAzdhKW6kZVxqkggjC1cwFzk1ggZKJGmuvQJO8ci
xSpYpyRQYZgXqPLhMLCmYaopZrBwbQIjKzc7MBo9Pa5DBiN3iQwekKJSdqXBP6K+zmE5X2FE
P702Ul6gY5DSok4TYUkeFS2VYjA7dj+f99uj2+1ufbTdHT2sfzxT0pwxNpHIQcEr2TfsFVak
c+tdFgt86sOliFigT1ovwqSMrYeXbIT/CbBazAJ90so00UcYSzhor49uwydbIqYavyhLn3ph
Ou11Ceg38UlB4os5U24Pt0KpetSk6W9/OvDOlGfVIZdXTaUOqmuvNfPZyenHrE29EcvbNPWo
Eej3lP4wzNI2MUh9pp/smXn5+vXH5va37+ufR7fE8Pe71fPDT0OO9dNcewsF9g2mFhlG8aHR
lGEV1bzPRPNvxr7H2/e6rS7l6YcPJ5/0OhWv+we87nu72q/vjuQTdQNvRP+52T8ciZeX7e2G
UNFqv/L6FYYZ04k5G+itP4lhLxanx2WRXmOaDCteWa/YeVKfTKQH0d2UF8nldC0S6gBhi0cj
6hUSymv1uL1bv/idCEKmEeGM8yJrZOOvkZDhVBkGzPik1XK66GIWeHxdYhPdsq+Y+kDlwKck
mDpFBKpc0x6YGHSiXmq2iFcvD1PDlZlZ2LQYzATTQq7Zl4pS31Jfv+z9Gqrw/an/JYH9Sq5Y
uRykYiFPgwm4P3JQeHNyHJlJyTU3U/nelIzs6wiw6Izhpizir5qP6K5knw7RBAkwNAUVc7xa
ZdHJOft2d79YYnHiNRSBWCmHOP1w7o0DgD+cMBtpLN4zTaozLmRcIxvQfwI7Sr5HLcsPdrJo
pTNsnh+sfImDpKj9bVPW1oMRGpy3QVJzK6MK2efiNb8Uy1nCMIBGeIkrNUOJTIKFJ5gaQ1E3
B9kBCc4PETixfp5SRX+nO7WIxQ2jKWnR7HOEFeMwAKtS5o0Pz848WCOFV2izLGhgPVoF1+Oq
9cnt4zPmO7CtBD0as1Q00isJj3/cWj+e+Syc3vgtBljsiyA6G+q3lGr1dLd9PMpfH7+udzpl
Itc8kddJF5aoE7qtiaoAw63y1quJML1U9WafcKI+qCkQ0cQTmiOFV++XBK0giYGh5bWHRWWv
4zRyjdBKMqclEl6r19PNGkjVgE2WhKpzKC65MAuXlOwCd+wHrMxJMS0CDPZi2Ai71PUvvJm2
zY/N190KTLXd9nW/eWJ2yjQJSEJ5vIVwkDpekxDRb1D6rhX7sd7EuO/VIj74uSLhUYOCeLgE
U4/00XpzBL03uZGfTw6RHKpm2GSne2EokhzRsJe5bBRzKhgYulkm0f9CzhsMpbesYI0s2yDt
aeo2sMmuPhx/6kJZ9X4f6cXWlIuw/tiVVXKJWCyDo/gdozBr9CDzWDRH8GPjYCaZ5/j8n1Qn
wXSu33ueBsbFjInfSNd/OfqGUcab+yeVheP2YX37ffN0b7xyhknN8YIUebI+v7mFj1/+i18A
WQcmz7vn9eOboXY6pOmaCq8GRdqbZh0bOfj68xv3a2X0GYPnfe9RdMRhZ8efzi2XWpFHorp2
m8M74FTJsKbCRZrUDU+sjzD/xgjqJgdJjm2Amc6bmZ6CdFJoVCKJzrvSuFGuIV0AJinsBZVx
WxhjXUQFJPncutsjnPiAIAFdC3jBjOPV1zhBDcvD8rqbVXRzxmQykySV+QQWHxBqmyS11aqi
iiYc2zAUmQSDPAugQcz6U05U86L0cOM0TIaIND1vTVbql26MpR+CUQp7mAU6ObcpfE0/7JKm
7eyv3jvuDgBMvMJrk4BokMH1lPVqkPAnHj2JqJbA3uzmhvggsRt7bqkw4ZnTdO64BuSjb2mF
hud+MK3GcDSRR0U2MQ49DWhYQ1TOWBZCI+nDb1BKw+ZqK3AE9dQ60OeYkhHKlQwaHEsNeh0P
59sHGh9DTmCO/uqmc4I7FaS7+njODFaPpBsqZegW0yXCnNceaD3pN8KaGNYVU3ENGwhnWfbo
IPzilWY/3z12s5vfmOk6DEQAiFMWk96YTmILUUzAjS7r9U8udYxzMqSjesg2LTL7wv0IxVLN
pR+EhhknanwEFwTOJT6xXQljJ8UzhcS+UKFAFNRoCSGEW17wnOqnd6U6EJzzJnZwiMDLV3g+
Y2oXVRgTTkRR1TXd+Zm1whEDvUlFhdcSYtLQnY+xKeSoR9rZkFPyV1Rh2TIkiIXpKJnKEJUX
uUbgS1GljR1QpZUtC1GV9Kj7OCiNGePOcDDwWutkmKMeymF75A7N5qliHkPIUfghqkuiUc9I
6/IuzJ0nLQL7l3lEqWc0xUhHhl2bIktsmZzedI0wSsQULKC6GjVmZQJiz2hOklm/4ccsMiai
SCJ8lhNUlspiXmBo3Y7LqC781s1lgwHsxSwyuX5W5M3w5P2jBf34l7mMCIRnbjAe0kxGVc+d
GR/YqcTLPZbdOKAAQ1NPQlZgPBxMDEPX4sNqIB5maVvHTnx1DWvF4qsS76sbpRTBFzE3tdEG
NTz2zNlT0OzjTK0kE/R5t3naf1dZAR/XL/f+qTQpfwu6TGC0TgFDYSerCdV1oy4t5imobOlw
MPT7JMVFm8jm89nAQb3J4JUwUETXucAHh52gdQus3tMwj5Kvs6BAg0dWFdDx13rUp/AfKJtB
4d7y6gd3csAGH8/mx/q3/eaxV6dfiPRWwXf+8M4qaI4K6z45Pj0zT7+rpAQZj7cO2QCzSoqI
zH6gMfsaAxyfV0xyENApF86tOlqryGSMZctEExpS3sVQ8zA63VhrqgwQv3hBrM3VB8T53ftT
axM3KZdSLOjdx7DkL5L+7QGk4SaX1eZW83a0/vp6f49HysnTy373ivn0zUevxRztgevazHll
AIfjbOVO+Xz81wlHpXI48SX0+Z1qDNrIYeca7cN+FGpvBGsS7kv8PzNqNZ06EkGGt3wOMO5Q
EkYJMLNOYpWE0WIeWTOEvzlfwiC4glr0Mf1gqvYt7YkIZ0iA0PgigBZH9QSSNJaRZGiM+SkX
k6vaEiezxv8qSi69yAaHpM1h3YQxTvBk6SBr6cIV2uV2R6Fdhdt5YJc2c2H8YJHLQ42YIa//
FhfbXIMhrZLhF4xL9Y4e+niMoVxDtqOolVcNvqRV5H5xiCfVg7eF8etimU+lPiTXT5HURT7l
uBhrwYscB0jUjLCvJSBX94MCG3EKAsZdYr+C4wZO276a8ZPz4+NjtwED7YTJ6FANgTGzmT+q
AxVF/dSh4G6H9DKaAnZa3BKt7Qx0h6hHyjw6cPtKFXPJHZqOmrKiSaqmNeWaC3ZZjR6jpnig
AzUvUC9Cw4e/EKWI4mQeO9em/dml3uItgRnIOL85Fvqw9BOWxHIQeLrrKNtKaims7+tVWAz1
Rn0sL8aVD2aQrK2Ycm8ler2IneSD6pAZ6Y+K7fPL2yN8fOr1WW2K8erp3tTUBCZvhG24sG7d
WGAMemrRnz3yUjFrMKSqLdmnVI0GIrKLMQFKI2rOUllegKYA+kJUWNd3SOqpKvgLAQe7p4Im
QRW4e8X935RiY8AYg3aHFhXYhZRu6m7l0sTQilHu/vvlefOE4RbQoMfX/fqvNfxjvb999+7d
f4wM9Hi/icqekybe2x2Gjgzs6F93UuBKLFUBOQyOhScomtbuSkTDvW3klfR0iBo6hZ+58Any
5VJhuhqWChgssVfTsrZuKygoNcxZGwiLZMmRKrAzCcqqhIql5JN7j9/jmNJxW2/hcMKfmgQM
i0awdvkMRY3dnPb01eHM/16bUf+AKYYNHjMloGE8S8XcG0EfTlJLpVcwW47qNkZptjmeW4Oo
V17L6X1H7Y+ff5ry4rtSJ+5W+9UR6hG36OM3xEU/1EntcVrZA13hdGgTV2HCjlN8oKE9HPQz
0aBvhZ7z8K7yWdJgovFurWEFw5M3ifOSkjrdDltW51HrLzR8RlMchNnk6JnWqV0fCZyPDQze
TR0/dwumWZ8oU16Y95h11n2rP+5IgOxVJlblGVe2eUtrBnQ+dK4ZDc6LUjWpcrbGwbg7jJ1X
oox5Gm2azzSjWwWoJZNRDgMYMjx7cUgwIymuBqIEhTI3w8aIIuw/VKUYE0vNwSdMOqduVWto
S03yqAyvVvZAeu+S6C0xDX8aHEWVht/ruFFUb5XVS8u9U0mZwSIAm5Htllef9ny5FfWE/vbj
jjZYLuQz84v2Z3i8JMhNL8dbE1M8fA+rDs90K0f0MVViZmhQm6frUsqvx2nLVDQetOeunoNq
jzPqXJR1XPgsoxHaWeFMXwACGTNMq155cfkaLvIcn0OC5qoP2PxmQbqgDDD0RLA1egsoJ5D9
i6sTYBSrUIm7hbQmzYEJc8vmazy8SG0sXkqeXo3IqvYZ6HXexF6FmDJUP8hkeQdUVWpNqsv1
7H4zrqmDrnVzlY4n1I//cioTKTnpcUqtxaHwqrP4p63qyQvqPSM2AnaL0ttPxp3BaNE/Ih5y
odAaj2TaCH4rNiQPUInrqb3NmBgUPp19bGDyIIO25s9PyVELzGbN8aVhlKosar1Ti6L3lMd6
++d693zLbu1lOATpL2VVmWdt5LHuhQ6opqD0np+Z38msTWmlourtRANEGMICUt50uDNt/9Jm
YOuKQKbdTNLBjDLMzcQmEyReCpamAna7gskfHPyjv7FOOnVawCCxKzi1aNVhhiev5KvMvM1z
pc4YlYvdgcJA1mAHBKmV5sP8oqsKjLHhtBhlF5miOIiSfrO0JCUOvajS6wOHZEhTNlE7kTHR
ZwjzvKNZv+xRfUeDMtz+sd6t7o0H5ihVjsHVlDmnzz5oCNwhoY5LKq+Ik1kcqSx0+2M8bOuV
5I6Yc8wOYiTazHgiM4ywmJHMmS6RvzQpG5Vn7BcfuDu321RTAP4yx8mwnBdhcek5TWrYE4vL
XsyWVsgB0vMyD7YU0mKU3Uyhp0zFIDtce+4QQwweDLS8sqSuseioCNus35cc2yxI1LjwGQ6c
o7b/A8h+w0GwigIA

--HcAYCG3uE/tztfnV--
