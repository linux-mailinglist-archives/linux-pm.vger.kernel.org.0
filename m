Return-Path: <linux-pm+bounces-38271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C883C72C5A
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 09:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 455A93582E2
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 08:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E10309EF6;
	Thu, 20 Nov 2025 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QIscJULl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C587A309EE0;
	Thu, 20 Nov 2025 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626791; cv=none; b=adp3CZMpNKyyQV006xeAO3MUuTKfSXyVsvs4LvudQdg/RQZGopOeCEfI7EUHSFVhaxc03MybpdsA2al2EN9xWUHSqdCsy7lGyJeRVeLn/8+TxluwCUhXe8JR9B+Nx4uGW1p3YJJjGu8NF3rLYoJZ5svjMb+mkawRxyNR0ShM91o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626791; c=relaxed/simple;
	bh=drjy7Om9+hTEtLqm8bf7E/TIxkEuaOGk9m3jpyHjmXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZm/7Ki9C9CwDAEU17LNdxfWRNjIaVkHvRF5MxZK4Laa9DmYdzK2mzYkCb480azzNbvR9SUYF6CV5gjzzSwcsrjVW96Aq6VE/QPwUkJOs3u9pMq7OH9sHOnwVR3PhLY/oM6Ox5IOoxNcKTxtM9YvfvgTT5tizdr2bzJbxTSDQuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QIscJULl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763626790; x=1795162790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=drjy7Om9+hTEtLqm8bf7E/TIxkEuaOGk9m3jpyHjmXw=;
  b=QIscJULlCLdxfiQykswZBON0l8+OS+VujBOd9p0uLqI7WAuJI6cQJtpS
   sQXElEdkpPM4SsUtwkSBJpDBZXtD0WHaOL1oDp8wyAIpw5/VjRGF8CxZT
   cCpMJHXBLHTnBc0h77NqJEw7iunBKKAihoCBIiRzvsx7MJYqlSgug7fqy
   JoQpaR6g+DQvvV6cqEj7CWptL+KB1EVDLZjnsiCsZEW1RZe9MMK3EoPmg
   AA0i+b9ix9CDWACBoKn6a6AZLHEmLipKpoax+/hMbClVloakg5znUUcqV
   AgAHmoYWLZjRu7DIOK4TAFZUb16IM7Ded5Pb1qz1YR+LeruUIwVdsVMMf
   w==;
X-CSE-ConnectionGUID: lV/Xk0OTQJGTkk/8bQilfg==
X-CSE-MsgGUID: tRsxvW1PQ4W57BVNLMTF9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="91167589"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="91167589"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 00:18:46 -0800
X-CSE-ConnectionGUID: Iuq2OIqcSFmO/p06c1h+KA==
X-CSE-MsgGUID: PYj2H+DuRYuxPZpffe72fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="190549759"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 20 Nov 2025 00:18:43 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLzsG-0003lX-0J;
	Thu, 20 Nov 2025 08:18:40 +0000
Date: Thu, 20 Nov 2025 16:17:56 +0800
From: kernel test robot <lkp@intel.com>
To: Lucas Zampieri <lzampier@redhat.com>, linux-input@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Lucas Zampieri <lzampier@redhat.com>,
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Bastien Nocera <hadess@hadess.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/1] HID: input: Add support for multiple batteries
 per device
Message-ID: <202511201624.yUv4VtBv-lkp@intel.com>
References: <20251119143005.1513531-2-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119143005.1513531-2-lzampier@redhat.com>

Hi Lucas,

kernel test robot noticed the following build errors:

[auto build test ERROR on hid/for-next]
[also build test ERROR on dtor-input/for-linus linus/master v6.18-rc6 next-20251119]
[cannot apply to dtor-input/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lucas-Zampieri/HID-input-Add-support-for-multiple-batteries-per-device/20251119-223834
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20251119143005.1513531-2-lzampier%40redhat.com
patch subject: [PATCH v3 1/1] HID: input: Add support for multiple batteries per device
config: sh-defconfig (https://download.01.org/0day-ci/archive/20251120/202511201624.yUv4VtBv-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251120/202511201624.yUv4VtBv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511201624.yUv4VtBv-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hid/hid-input.c: In function 'hidinput_hid_event':
>> drivers/hid/hid-input.c:1550:25: error: implicit declaration of function 'hidinput_update_battery'; did you mean 'hidinput_find_battery'? [-Wimplicit-function-declaration]
    1550 |                         hidinput_update_battery(bat, usage->hid, value);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                         hidinput_find_battery


vim +1550 drivers/hid/hid-input.c

  1536	
  1537	void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value)
  1538	{
  1539		struct input_dev *input;
  1540		struct hid_report *report = field->report;
  1541		unsigned *quirks = &hid->quirks;
  1542	
  1543		if (!usage->type)
  1544			return;
  1545	
  1546		if (usage->type == EV_PWR) {
  1547			struct hid_battery *bat = hidinput_find_battery(hid, report->id);
  1548	
  1549			if (bat)
> 1550				hidinput_update_battery(bat, usage->hid, value);
  1551			return;
  1552		}
  1553	
  1554		if (!field->hidinput)
  1555			return;
  1556	
  1557		input = field->hidinput->input;
  1558	
  1559		if (usage->hat_min < usage->hat_max || usage->hat_dir) {
  1560			int hat_dir = usage->hat_dir;
  1561			if (!hat_dir)
  1562				hat_dir = (value - usage->hat_min) * 8 / (usage->hat_max - usage->hat_min + 1) + 1;
  1563			if (hat_dir < 0 || hat_dir > 8) hat_dir = 0;
  1564			input_event(input, usage->type, usage->code    , hid_hat_to_axis[hat_dir].x);
  1565			input_event(input, usage->type, usage->code + 1, hid_hat_to_axis[hat_dir].y);
  1566			return;
  1567		}
  1568	
  1569		/*
  1570		 * Ignore out-of-range values as per HID specification,
  1571		 * section 5.10 and 6.2.25, when NULL state bit is present.
  1572		 * When it's not, clamp the value to match Microsoft's input
  1573		 * driver as mentioned in "Required HID usages for digitizers":
  1574		 * https://msdn.microsoft.com/en-us/library/windows/hardware/dn672278(v=vs.85).asp
  1575		 *
  1576		 * The logical_minimum < logical_maximum check is done so that we
  1577		 * don't unintentionally discard values sent by devices which
  1578		 * don't specify logical min and max.
  1579		 */
  1580		if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
  1581		    field->logical_minimum < field->logical_maximum) {
  1582			if (field->flags & HID_MAIN_ITEM_NULL_STATE &&
  1583			    (value < field->logical_minimum ||
  1584			     value > field->logical_maximum)) {
  1585				dbg_hid("Ignoring out-of-range value %x\n", value);
  1586				return;
  1587			}
  1588			value = clamp(value,
  1589				      field->logical_minimum,
  1590				      field->logical_maximum);
  1591		}
  1592	
  1593		switch (usage->hid) {
  1594		case HID_DG_ERASER:
  1595			report->tool_active |= !!value;
  1596	
  1597			/*
  1598			 * if eraser is set, we must enforce BTN_TOOL_RUBBER
  1599			 * to accommodate for devices not following the spec.
  1600			 */
  1601			if (value)
  1602				hid_report_set_tool(report, input, BTN_TOOL_RUBBER);
  1603			else if (report->tool != BTN_TOOL_RUBBER)
  1604				/* value is off, tool is not rubber, ignore */
  1605				return;
  1606			else if (*quirks & HID_QUIRK_NOINVERT &&
  1607				 !test_bit(BTN_TOUCH, input->key)) {
  1608				/*
  1609				 * There is no invert to release the tool, let hid_input
  1610				 * send BTN_TOUCH with scancode and release the tool after.
  1611				 */
  1612				hid_report_release_tool(report, input, BTN_TOOL_RUBBER);
  1613				return;
  1614			}
  1615	
  1616			/* let hid-input set BTN_TOUCH */
  1617			break;
  1618	
  1619		case HID_DG_INVERT:
  1620			report->tool_active |= !!value;
  1621	
  1622			/*
  1623			 * If invert is set, we store BTN_TOOL_RUBBER.
  1624			 */
  1625			if (value)
  1626				hid_report_set_tool(report, input, BTN_TOOL_RUBBER);
  1627			else if (!report->tool_active)
  1628				/* tool_active not set means Invert and Eraser are not set */
  1629				hid_report_release_tool(report, input, BTN_TOOL_RUBBER);
  1630	
  1631			/* no further processing */
  1632			return;
  1633	
  1634		case HID_DG_INRANGE:
  1635			report->tool_active |= !!value;
  1636	
  1637			if (report->tool_active) {
  1638				/*
  1639				 * if tool is not set but is marked as active,
  1640				 * assume ours
  1641				 */
  1642				if (!report->tool)
  1643					report->tool = usage->code;
  1644	
  1645				/* drivers may have changed the value behind our back, resend it */
  1646				hid_report_set_tool(report, input, report->tool);
  1647			} else {
  1648				hid_report_release_tool(report, input, usage->code);
  1649			}
  1650	
  1651			/* reset tool_active for the next event */
  1652			report->tool_active = false;
  1653	
  1654			/* no further processing */
  1655			return;
  1656	
  1657		case HID_DG_TIPSWITCH:
  1658			report->tool_active |= !!value;
  1659	
  1660			/* if tool is set to RUBBER we should ignore the current value */
  1661			if (report->tool == BTN_TOOL_RUBBER)
  1662				return;
  1663	
  1664			break;
  1665	
  1666		case HID_DG_TIPPRESSURE:
  1667			if (*quirks & HID_QUIRK_NOTOUCH) {
  1668				int a = field->logical_minimum;
  1669				int b = field->logical_maximum;
  1670	
  1671				if (value > a + ((b - a) >> 3)) {
  1672					input_event(input, EV_KEY, BTN_TOUCH, 1);
  1673					report->tool_active = true;
  1674				}
  1675			}
  1676			break;
  1677	
  1678		case HID_UP_PID | 0x83UL: /* Simultaneous Effects Max */
  1679			dbg_hid("Maximum Effects - %d\n",value);
  1680			return;
  1681	
  1682		case HID_UP_PID | 0x7fUL:
  1683			dbg_hid("PID Pool Report\n");
  1684			return;
  1685		}
  1686	
  1687		switch (usage->type) {
  1688		case EV_KEY:
  1689			if (usage->code == 0) /* Key 0 is "unassigned", not KEY_UNKNOWN */
  1690				return;
  1691			break;
  1692	
  1693		case EV_REL:
  1694			if (usage->code == REL_WHEEL_HI_RES ||
  1695			    usage->code == REL_HWHEEL_HI_RES) {
  1696				hidinput_handle_scroll(usage, input, value);
  1697				return;
  1698			}
  1699			break;
  1700	
  1701		case EV_ABS:
  1702			if ((field->flags & HID_MAIN_ITEM_RELATIVE) &&
  1703			    usage->code == ABS_VOLUME) {
  1704				int count = abs(value);
  1705				int direction = value > 0 ? KEY_VOLUMEUP : KEY_VOLUMEDOWN;
  1706				int i;
  1707	
  1708				for (i = 0; i < count; i++) {
  1709					input_event(input, EV_KEY, direction, 1);
  1710					input_sync(input);
  1711					input_event(input, EV_KEY, direction, 0);
  1712					input_sync(input);
  1713				}
  1714				return;
  1715	
  1716			} else if (((*quirks & HID_QUIRK_X_INVERT) && usage->code == ABS_X) ||
  1717				   ((*quirks & HID_QUIRK_Y_INVERT) && usage->code == ABS_Y))
  1718				value = field->logical_maximum - value;
  1719			break;
  1720		}
  1721	
  1722		/*
  1723		 * Ignore reports for absolute data if the data didn't change. This is
  1724		 * not only an optimization but also fixes 'dead' key reports. Some
  1725		 * RollOver implementations for localized keys (like BACKSLASH/PIPE; HID
  1726		 * 0x31 and 0x32) report multiple keys, even though a localized keyboard
  1727		 * can only have one of them physically available. The 'dead' keys
  1728		 * report constant 0. As all map to the same keycode, they'd confuse
  1729		 * the input layer. If we filter the 'dead' keys on the HID level, we
  1730		 * skip the keycode translation and only forward real events.
  1731		 */
  1732		if (!(field->flags & (HID_MAIN_ITEM_RELATIVE |
  1733		                      HID_MAIN_ITEM_BUFFERED_BYTE)) &&
  1734				      (field->flags & HID_MAIN_ITEM_VARIABLE) &&
  1735		    usage->usage_index < field->maxusage &&
  1736		    value == field->value[usage->usage_index])
  1737			return;
  1738	
  1739		/* report the usage code as scancode if the key status has changed */
  1740		if (usage->type == EV_KEY &&
  1741		    (!test_bit(usage->code, input->key)) == value)
  1742			input_event(input, EV_MSC, MSC_SCAN, usage->hid);
  1743	
  1744		input_event(input, usage->type, usage->code, value);
  1745	
  1746		if ((field->flags & HID_MAIN_ITEM_RELATIVE) &&
  1747		    usage->type == EV_KEY && value) {
  1748			input_sync(input);
  1749			input_event(input, usage->type, usage->code, 0);
  1750		}
  1751	}
  1752	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

