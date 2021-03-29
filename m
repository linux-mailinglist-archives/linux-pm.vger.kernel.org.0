Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A3E34C24E
	for <lists+linux-pm@lfdr.de>; Mon, 29 Mar 2021 05:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhC2Dvt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Mar 2021 23:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhC2Dvm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Mar 2021 23:51:42 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B484AC061574;
        Sun, 28 Mar 2021 20:51:42 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x26so9064612pfn.0;
        Sun, 28 Mar 2021 20:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Mf99Lud0sd0TAzBAUBWRcKZAajS+wW0zsplvFp/ic10=;
        b=LYKzVGyiZpZlHqvy7GkH8wAu0zJ8FD1qQtpGye1J3J1tJ59CVN70nIbLK+rae4daWh
         qI52NC1UOminStS1fIYke9UY9Lyu7nECDh/LnEkmHGZ7vFg5Ndkf2qCK5MO6tgeLkUqi
         p0Tm+YGZG6VV6IsWdbPzN3mBVyVSE5XB7n5LP4XQy46RZu+s6erTWGlqDe5q01RGbANB
         ugLpYtoK6YOkMcYHlvMmQr5HpDHucd+o0qIoon2SKL4SMQSg5siMKiFSvG8mIxnup43p
         wmwwkq191/bvpK2YFkVlOqodqt8CK3pzW/pDjv+hX8Qcvl3xc8QUPxKaLGrK7eE9HbFR
         yuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Mf99Lud0sd0TAzBAUBWRcKZAajS+wW0zsplvFp/ic10=;
        b=DE+oXHeaNSrDMypnIXtzQWYSvnUt77ZC8DFYh51RZnp2NFTC2XSapZflMTx+BOUfI9
         BuCMvtnMPCVLs1HUbRP6Rxvz4d4tZ9gEVJ0rQleOm5Jccz08N9WAJnygwsIP+R5quJDo
         bdrHmhsNqUz0HFzGPYUotj7ucR2mvUhP7Btn6gTWxD2FxjSa9QMdNZm5uSF4EfC0MHEF
         xKzoPS3locJtoHcoLYgWbw/5K2BnymragijYbDKEvviB0DsHQGkSM4srHk1YCIj85H/Z
         vLxZ3agZaA3nh/SMGiaYjF+1Db72ZyW0Yx6XxIlbm0ybLlYVrPb8j6XsZfd9p4uTBdqQ
         +WUA==
X-Gm-Message-State: AOAM533Et6xIWy+4w9kiKxivS7uQ5ouGcgUuvwHNqkqQLhgNNNDV034M
        ihyeb6IOAIA2gyaNpSo9ouw=
X-Google-Smtp-Source: ABdhPJwbiz5FBon7I9unJ7Jxjd+rj4vWJd2uXodh6Gz79b3MwQUA4KOmMHL2JqCdjhAM/NrIe41doA==
X-Received: by 2002:aa7:8f31:0:b029:1f8:987a:53dc with SMTP id y17-20020aa78f310000b02901f8987a53dcmr23157047pfr.58.1616989902268;
        Sun, 28 Mar 2021 20:51:42 -0700 (PDT)
Received: from MacBook-Pro.local ([122.10.101.134])
        by smtp.gmail.com with ESMTPSA id e9sm14260854pgk.69.2021.03.28.20.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 20:51:41 -0700 (PDT)
Subject: Re: [PATCH 1/2] cpupower: fix amd cpu (family < 0x17) active state
 issue
From:   xufuhai <xufuhai1992@gmail.com>
To:     linux@dominikbrodowski.net, sherry.hurwitz@amd.com, trenn@suse.com,
        linux-pm@vger.kernel.org, rrichter@amd.com,
        nathan.fontenot@amd.com, bp@suse.de, latha@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Cc:     lishujin@kuaishou.com
References: <35ab0d0a-f9ce-b4d7-cd85-3cd8a8638ab6@gmail.com>
Message-ID: <61bffd2d-dd37-d1e7-2b19-96d066e10397@gmail.com>
Date:   Mon, 29 Mar 2021 11:51:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <35ab0d0a-f9ce-b4d7-cd85-3cd8a8638ab6@gmail.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

yeah Shuah~ thanks for your reply

For this issue, not meaning "current CPU frequency" but "boost state support--->Active" during 
"cpupower frequency-info" command as below:

	boost state support:
    		Supported: yes
    		Active: yes/no

I think the state returned from the command for amd cpu (family < 0x17) should be like as below:

	as non-root Active state:
		Active: Error while evaluating Boost Capabilities on CPU xx -- are you root?
	
	as root Active state:
		Active: yes (if supported)
			no  (if not supprted)

I don't wanna see the state returned like below:
	
	as non-root Active state:
		Active: yes
	
	as root Active state:
		Active: yes (if supported)
			no  (if not supprted)
	
I will paste the related code by detailed for showing the issue:
	
	if amd cpu family < 0x17 , will run amd_pci_get_num_boost_states function:
-----------------------------------------------------
/linux/tools/power/cpupower/utils/helper/misc.c
 
	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB) {
		*support = 1;

		/* AMD Family 0x17 does not utilize PCI D18F4 like prior
		 * families and has no fixed discrete boost states but
		 * has Hardware determined variable increments instead.
		 */

		if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB_MSR) {
			if (!read_msr(cpu, MSR_AMD_HWCR, &val)) {
				if (!(val & CPUPOWER_AMD_CPBDIS))
					*active = 1;
			}
		} else {
			ret = amd_pci_get_num_boost_states(active, states);
			if (ret)
				return ret;
		}
---------------------------------------------------

/linux/tools/power/cpupower/utils/helper/amd.c
amd_pci_get_num_boost_states:
	
	val = pci_read_byte(device, 0x15c);

 	if (val & 3)
 		*active = 1;
 	else
----------------------------------------------------

pci_read_byte will memset val to 0xff if caller has no permission to access to read from pci_dev
but for amd_pci_get_num_boost_states, active state will set 1 meaning "yes". I believe that active
state should return negative value to caller function meaning "have no permission" will showing "
Error while evaluating Boost Capabilities on CPU xx -- are you root?"  

----------------------------------------------------
static inline void
pci_read_data(struct pci_dev *d, void *buf, int pos, int len)
{
  if (pos & (len-1))
    d->access->error("Unaligned read: pos=%02x, len=%d", pos, len);
  if (pos + len <= d->cache_len)
    memcpy(buf, d->cache + pos, len);
  else if (!d->methods->read(d, pos, buf, len))
    memset(buf, 0xff, len);
}

byte
pci_read_byte(struct pci_dev *d, int pos)
{
  byte buf;
  pci_read_data(d, &buf, pos, 1);
  return buf;
}
----------------------------------------------------


ÔÚ 2021/3/24 ÏÂÎç6:27, xufuhai Ð´µÀ:
> From: xufuhai <xufuhai@kuaishou.com>
> 
> For the old  AMD processor (family < 0x17), cpupower will call the
> amd_pci_get_num_boost_states function, but for the non-root user
> pci_read_byte function (implementation comes from the psutil library),
> val will be set to 0xff, indicating that there is no read function
> callback. At this time, the original logic will set the cpupower turbo
> active state to yes. This is an obvious issue~
> 
> Reproduce procedure:
> 	cpupower frequency-info
> 
> Signed-off-by: xufuhai <xufuhai@kuaishou.com>
> Signed-off-by: chenguanqiao <chenguanqiao@kuaishou.com>
> Signed-off-by: lishujin <lishujin@kuaishou.com>
> ---
>  tools/power/cpupower/utils/helpers/amd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
> index 97f2c857048e..6f9504906afa 100644
> --- a/tools/power/cpupower/utils/helpers/amd.c
> +++ b/tools/power/cpupower/utils/helpers/amd.c
> @@ -137,6 +137,13 @@ int amd_pci_get_num_boost_states(int *active, int *states)
>  		return -ENODEV;
>  
>  	val = pci_read_byte(device, 0x15c);
> +
> +	/* If val is 0xff, meaning has no permisson to
> +	 * get the boost states, return -1
> +	 */
> +	if (val == 0xff)
> +		return -1;
> +
>  	if (val & 3)
>  		*active = 1;
>  	else
> 
