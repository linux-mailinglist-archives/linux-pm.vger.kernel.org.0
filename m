Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2161B4B6E
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 19:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDVRPK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 13:15:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48106 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgDVRPJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2020 13:15:09 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 8148A2A12D7
Subject: Re: [PATCH 1/2] thermal: core: Let thermal zone device's mode be
 stored in its struct
To:     kbuild test robot <lkp@intel.com>, linux-pm@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Zhang Rui <rui.zhang@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Peter Kaestle <peter@piie.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
References: <20200420181741.13167-2-andrzej.p@collabora.com>
 <202004230011.fOOpjG9V%lkp@intel.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <7a914ced-992c-0c00-ebaf-b635d130729f@collabora.com>
Date:   Wed, 22 Apr 2020 19:15:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <202004230011.fOOpjG9V%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

W dniu 22.04.2020 o 19:03, kbuild test robot pisze:
> Hi Andrzej,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on 79799562bf087b30d9dd0fddf5bed2d3b038be08]
> 
> url:    https://github.com/0day-ci/linux/commits/Andrzej-Pietrasiewicz/Stop-monitoring-disabled-devices/20200422-133553
> base:    79799562bf087b30d9dd0fddf5bed2d3b038be08
> config: i386-allyesconfig (attached as .config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=i386
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/thermal/intel/int340x_thermal/int3400_thermal.c:257:18: error: 'THERMAL_ZONE_DISABLED' undeclared here (not in a function); did you mean 'THERMAL_DEVICE_DISABLED'?
>       .initial_mode = THERMAL_ZONE_DISABLED,
>                       ^~~~~~~~~~~~~~~~~~~~~
>                       THERMAL_DEVICE_DISABLED

Addressed in PATCH RESEND 1/2, in reply to PATCH 1/2.

Andrzej

