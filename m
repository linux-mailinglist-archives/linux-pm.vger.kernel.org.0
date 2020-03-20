Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33EA218D2ED
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 16:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgCTPac (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 11:30:32 -0400
Received: from cmta19.telus.net ([209.171.16.92]:51467 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbgCTPac (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Mar 2020 11:30:32 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Mar 2020 11:30:31 EDT
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id FJTXjh08lRCqvFJTZjlAsp; Fri, 20 Mar 2020 09:22:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1584717743; bh=Wjond4bi647NoK6bZUR6AksEQPQt06S+xLbit8dNH+0=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=PX6633KEr7NJCOcvrEQhVLpERDb7PP6hEoED4/+w6NcfL8DTuWg0UQtd8DGI1jBE1
         yWC0On8UbySfkyhfrpU8snujIjmahh100i63Jj9YgSp8GyfoiJt7EeWui9VBiEdoli
         ZCR7SgMa8JcWePgHalkLUetsJHqw8+by+z1I8V7YU9LAgbmIMi+3AwJqZdqQCzS8U3
         k/gF2CZgLNeWSa/k2vWL5zP1zI8vfbs6d6BrweWzP0Z8v1eT/Oc1+k6ww96vXwFsN+
         /atbazUJIpSa6Tz/T5T19V2xz0qGOEklrJcIPdoQDdIyYo0ysWKQrjCVlAyPMES+jY
         XqjskilHkuw+w==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=NruvjPVJ c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8 a=gu6fZOg2AAAA:8 a=_k8VhL4GC70Ti1dz9ewA:9
 a=CjuIK1q_8ugA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
 a=2RSlZUUhi9gRBrsHwhhZ:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Len Brown'" <lenb@kernel.org>,
        "'Antti Laakso'" <antti.laakso@linux.intel.com>
Cc:     "'Len Brown'" <len.brown@intel.com>, <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>
References: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584679387.git.len.brown@intel.com> <7c3808082a40a96e95808864fe814b4e68238a46.1584679387.git.len.brown@intel.com>
In-Reply-To: <7c3808082a40a96e95808864fe814b4e68238a46.1584679387.git.len.brown@intel.com>
Subject: RE: [PATCH 09/10] tools/power turbostat: Print cpuidle information
Date:   Fri, 20 Mar 2020 08:22:16 -0700
Message-ID: <000001d5fecb$594be560$0be3b020$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdX+d6f5ISVBpDnmRe+vCBwTcoM4IgATU1nQ
Content-Language: en-ca
X-CMAE-Envelope: MS4wfAW8mJohM/zvoDcVVgJaUiwEv5cS5PKfUeAyJ44dCLWJQyX23eRhz8iwTyLh20bK4WLhtgh0qOozsIIwmC3F16EM6uuQIAlDoZ9ckTJq34na5eVSPa8h
 Q5+VLzdSM6gmIxQ/eYcoxff2N0yPIAjQ+x6o9SmTn4v6eM9po07xCzsW90rZXR/Sy0qaUH8EVEusdA6mT1j4tsovCH7SCaOseDzwgWNmrgzD19GNFWU/2mzo
 7dQfEmgQy80MA2HjKhcOmLKOh/nSlZK9MaL/upthIDtNqiJVEcnZi6ky3SpoRIRz802U69GUumJllKaDwQ6xlA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Len, Antti,

I didn't actually try it yet.
This reply is just from reading the patches.

On 2020.03.19 22:23 Len Brown wrote:

> From: Antti Laakso <antti.laakso@linux.intel.com>
>
> Print cpuidle driver and governor.
>
> Signed-off-by: Antti Laakso <antti.laakso@linux.intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>

...

> +	sprintf(path, "/sys/devices/system/cpu/cpuidle/current_governor_ro");
> +	input = fopen(path, "r");
> +	if (input == NULL) {
> +		fprintf(outf, "NSFOD %s\n", path);
> +		return;
> +	}
> +	if (!fgets(cpuidle_buf, sizeof(cpuidle_buf), input))
> +		err(1, "%s: failed to read file", path);
> +	fclose(input);
> +
> +	fprintf(outf, "cpuidle governor: %s", cpuidle_buf);
> +

There is a problem here if one has the 'cpuidle_sysfs_switch'
in the kernel command line (which I do always), because that
(not) variable name changes as a function of the switch [2].

I have:

$ grep . /sys/devices/system/cpu/cpuidle/*
/sys/devices/system/cpu/cpuidle/available_governors:ladder menu teo
/sys/devices/system/cpu/cpuidle/current_driver:intel_idle
/sys/devices/system/cpu/cpuidle/current_governor:teo

And in grub:

GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1 consoleblank=300 intel_pstate=passive cpuidle_sysfs_switch cpuidle.governor=teo"

Note that there was talk of getting rid of the command line switch [1 at the end], which would be great.
Copied below:

On 2019.09.02 14:59 Rafael wrote:

> FWIW, I've been thinking about getting rid of the cpuidle_sysfs_switch
> command line option and always allowing user space to switch cpuidle
> governors at run time.  At least I see no reason why that would not
> work ATM.

[1] https://marc.info/?l=linux-pm&m=156746153919195&w=2
[2] Documentation/admin-guide/pm/cpuidle.rst (search for 'current_governor_ro')

... Doug


