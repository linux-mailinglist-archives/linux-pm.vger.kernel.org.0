Return-Path: <linux-pm+bounces-38288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC1FC72EEC
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 09:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C2E623499B5
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 08:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E7230BF67;
	Thu, 20 Nov 2025 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IEA/urtv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2B3081C6;
	Thu, 20 Nov 2025 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628112; cv=none; b=WarSw/jcTWcPUQT7P1yS6w3TORXeXc/1W2KE7IYwdh/M+oFqBRMq7Ce7nJwTvF29TZCMyCh1jI/10nD3LAQXJwwbqrvOt4DdgGu0p0VwbwbrFObG1rwyI5MRei4YybELOxNmKU9S8O1BsZw/N7xpAlx9vGiNHaDfTtZps7hTg+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628112; c=relaxed/simple;
	bh=cqxl+IyOWcKo/tRDHpPMwN3FlYVqmhu45UPNVMkoDmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JygIu+5Sh25hxNNlsmSnn0CGQBdLjvtNAWAc8mcn9qGCoYmthCRSlvTAkkjW37pYrGFRcWn09gNGAO8krOGqzBqC1nDQMp6kOfBzmfoMOQq25/XhHLHVOWxjrqQN9t2zZ77le4mICmOsbM99s3Cx3yPcQEuHK01VH//9kzq4qiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IEA/urtv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763628110; x=1795164110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cqxl+IyOWcKo/tRDHpPMwN3FlYVqmhu45UPNVMkoDmI=;
  b=IEA/urtv8IVpyEAJMUcc65h0JavctC/qYEUCoV7yo3Nr4Zy6Vt3I3zQg
   YA+5U+LAdzIDQWIoSNFVFfVSNiakIf48SKXWXYIqdH+82YUTOZVVVTQBH
   4WBk2R5bFXO97ERTQJH6zJlUgyIBajc8Kcv2q7AKU09TSKSir1Z71his6
   OZBjhJmBLsCZtd/SuYJ5KW+Eq7rl37nVaJeaI9vno0BIvVVeWb3vZ8Vjf
   SJI9s+iHeTQKGAT0XJZJb2Rp6UMi08h69hP8N7lbvdp+U6L2zuAE7pluf
   GYGVNnNS1Pvz6hlOW6K79vsgbEZ/MRj7QWkFfHofqTc6JvlnDHQrapKsU
   Q==;
X-CSE-ConnectionGUID: 3F3h8EXlSyqDxk8pNTPk0w==
X-CSE-MsgGUID: L7EDRr18TJWNB7x4txfIfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="68295794"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="68295794"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 00:41:47 -0800
X-CSE-ConnectionGUID: nyAeXKxYQR+eXBe+0BjcFg==
X-CSE-MsgGUID: 4rYd4p4vQ3K97EKMM0T3ug==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 20 Nov 2025 00:41:45 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vM0EY-0003mb-2B;
	Thu, 20 Nov 2025 08:41:42 +0000
Date: Thu, 20 Nov 2025 16:40:44 +0800
From: kernel test robot <lkp@intel.com>
To: Lucas Zampieri <lzampier@redhat.com>, linux-input@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Lucas Zampieri <lzampier@redhat.com>, linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Bastien Nocera <hadess@hadess.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/1] HID: input: Add support for multiple batteries
 per device
Message-ID: <202511201651.tkKTEKpn-lkp@intel.com>
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
config: um-defconfig (https://download.01.org/0day-ci/archive/20251120/202511201651.tkKTEKpn-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9e9fe08b16ea2c4d9867fb4974edf2a3776d6ece)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251120/202511201651.tkKTEKpn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511201651.tkKTEKpn-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hid/hid-input.c:1550:4: error: call to undeclared function 'hidinput_update_battery'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1550 |                         hidinput_update_battery(bat, usage->hid, value);
         |                         ^
   1 error generated.


vim +/hidinput_update_battery +1550 drivers/hid/hid-input.c

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

