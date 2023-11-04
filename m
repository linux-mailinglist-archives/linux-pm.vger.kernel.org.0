Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666D87E1080
	for <lists+linux-pm@lfdr.de>; Sat,  4 Nov 2023 18:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjKDRd2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Nov 2023 13:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKDRd2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Nov 2023 13:33:28 -0400
X-Greylist: delayed 1196 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 04 Nov 2023 10:33:25 PDT
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A0C1BF
        for <linux-pm@vger.kernel.org>; Sat,  4 Nov 2023 10:33:24 -0700 (PDT)
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 4SN42J5cCDzDST
        for <linux-pm@vger.kernel.org>; Sat,  4 Nov 2023 13:13:28 -0400 (EDT)
Received: from xps-9320 (ip70-164-218-85.oc.oc.cox.net [70.164.218.85])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4SN42G1hKhzKZx;
        Sat,  4 Nov 2023 13:13:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1699118007; bh=u7EIG0EvfDuYk/dOF0Yu6AZmkXKYvTrht2OIEK++7U8=;
        h=Date:From:Reply-To:To:cc:Subject;
        b=E7aF+kVokJDhCpp1gHRtKspc5NOna8oHfLmQqGVK96Na/jf2L+4Et6PFQ32XvlqHh
         MocNQ6VYmOXepPUuDAPcN8h126ErmVkfWYQHhvzIHftSxiNaheJUAoRm9QDqUaN0+n
         r2i8mjDSZuQ7aMmaT7637wWk1D7X1oKva1hDMpXA=
Date:   Sat, 4 Nov 2023 10:13:24 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Kenneth R. Crudup" <kenny@panix.com>
cc:     vidyas@nvidia.com, bhelgaas@google.com,
        kai.heng.feng@canonical.com, andrea.righi@canonical.com,
        vicamo.yang@canonical.com, linux-pm@vger.kernel.org
Subject: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
Message-ID: <218aa81f-9c6-5929-578d-8dc15f83dd48@panix.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1999187219-1699118006=:25114"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1999187219-1699118006=:25114
Content-Type: text/plain; charset=US-ASCII


I have a Dell XPS-9320 with an Alderlake chipset, and the NVMe behind a
VMD device:

----
[    0.127342] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1280P (family: 0x6, model: 0x9a, stepping: 0x3)
----
0000:00:0e.0 0104: 8086:467f
        Subsystem: 1028:0af3
        Flags: bus master, fast devsel, latency 0, IOMMU group 9
        Memory at 603c000000 (64-bit, non-prefetchable) [size=32M]
        Memory at 72000000 (32-bit, non-prefetchable) [size=32M]
a7152be79b6        Memory at 6040100000 (64-bit, non-prefetchable) [size=1M]
        Capabilities: <access denied>
        Kernel driver in use: vmd
----

The only release kernel that was able to get this laptop to fully get into
low-power (unfortunately only s0ix) was the Ubuntu-6.2.0- ... series from
Ubuntu
(remote git://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/lunar).

I'd bisected it to the following commits (in this order):

4ff116d0d5fd PCI/ASPM: Save L1 PM Substates Capability for suspend/resume
5e85eba6f50d PCI/ASPM: Refactor L1 PM Substates Control Register programming
1a0102a08f20 UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD domain
47c7bfd31514 UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints behind VMD
154d48da2c57 UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name instead

Without the patches I never see Pkg%PC8 or higher(? lower?), nor i915 states
DC5/6, all necssary for SYS%LPI/CPU%LPI. I've attached a little script I use
alongside turbostat for verifying low-power operation (and also for seeing
what chipset subsystem may be preventing it).

The first two are in Linus' trees, but were reverted (4ff116d0d5fd in
a7152be79b6, 5e85eba6f50d in ff209ecc376a). The last three come from Ubuntu's
Linux trees (see remote spec above). The first two remain reverted in the
Ubuntu trees, but if I put them back, I get increased power savings during
suspend/resume cycles.

Considering the power draw is really significant without these patches (10s
of %s per hour) and I'd think Dell would have sold some decent number of
these laptops, I'd been patiently waiting for these patches, or some variant
to show up in the stable trees, but so far I'm up to the 6.6 stable kernel
and still having to manually cherry-pick these, so I thought maybe I could
bring this to the PM maintainers' attention so at least start a discussion
about this issue.

Apologies about the Maintainer Spam, and if this is already being discussed.

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
--8323329-1999187219-1699118006=:25114
Content-Type: text/plain; charset=US-ASCII; name=list-sleep-params
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename=list-sleep-params

IyEvYmluL2Jhc2ggLWUNCmRhdGUNCmVncmVwIC1IciAuIC9zeXMvY2xhc3Mv
ZHJtL2NhcmQwL3Bvd2VyL3JjNl9yZXNpZGVuY3lfbXMgXA0KIC9zeXMvZGV2
aWNlcy9zeXN0ZW0vY3B1L2NwdWlkbGUvbG93X3Bvd2VyX2lkbGVfc3lzdGVt
X3Jlc2lkZW5jeV91cyBcDQogL3N5cy9rZXJuZWwvZGVidWcvcG1jX2NvcmUv
cGFja2FnZV9jc3RhdGVfc2hvdyBcDQogL3N5cy9rZXJuZWwvZGVidWcvcG1j
X2NvcmUvc2xwX3MwX3Jlc2lkZW5jeV91c2VjIFwNCiAvc3lzL2tlcm5lbC9k
ZWJ1Zy9kcmkvMC9pOTE1X2VkcF9wc3Jfc3RhdHVzIFwNCiAvc3lzL2tlcm5l
bC9kZWJ1Zy9kcmkvMC9pOTE1X2RtY19pbmZvIHwgdGVlIC1hIH4vRHJvcGJv
eC9YUFMtNzM5MC9zbGVlcC1wYXJhbXMNCmVncmVwICdcKG5zXCk6IFteMF0n
IC9zeXMva2VybmVsL2RlYnVnL3BtY19jb3JlL2x0cl9zaG93IHwgY3V0IC1k
JwknIC1mMSwzLDQgfCBzZWQgLWUgJ3M7WwldWwldKjsgOycgfCB0ZWUgLWEg
fi9Ecm9wYm94L1hQUy03MzkwL3NsZWVwLXBhcmFtcw0KZWdyZXAgLUhyICI6
IE9uIiAvc3lzL2tlcm5lbC9kZWJ1Zy9wbWNfY29yZS9wY2hfaXBfcG93ZXJf
Z2F0aW5nX3N0YXR1cyB8IHRlZSAtYSAvZGV2L3R0eSB8IHRlZSAtYSB+L0Ry
b3Bib3gvWFBTLTczOTAvc2xlZXAtcGFyYW1zIHwgd2MgLWwNCmVncmVwIE5v
IC9zeXMva2VybmVsL2RlYnVnL3BtY19jb3JlL3NscF9zMF9kZWJ1Z19zdGF0
dXMgMj4vZGV2L251bGwgfCB0ZWUgLWEgfi9Ecm9wYm94L1hQUy03MzkwL3Ns
ZWVwLXBhcmFtcw0K

--8323329-1999187219-1699118006=:25114--
