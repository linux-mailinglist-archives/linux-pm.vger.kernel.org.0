Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14B521C596
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jul 2020 19:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgGKRtq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Jul 2020 13:49:46 -0400
Received: from mailrelay2-3.pub.mailoutpod1-cph3.one.com ([46.30.212.11]:38832
        "EHLO mailrelay2-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728507AbgGKRtp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Jul 2020 13:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:subject:message-id:to:
         from:date:from;
        bh=XPY/Ygi3XaerueYBkHDnVuko1AdEHPalOWhfV5txzKM=;
        b=M4u3MiycYmJuDpZEBNmSiEy3SdbjDX92qL7C6Q+sWi3kJC0pIV5Mnn6O9ss0p61C7SI4WaTPAlQBP
         xvLoPx/+VInh6qf4qD7m10Ym5q+2b39BUjBYqWU4pzd3Z510AkLaJilDooeJSwWtT7a2nGDimRj7Z3
         1h4GPp+SnsmBpM95USibfDm6vfpPQq9tr7MoRcq0YLBh6EPBN7O84T0viCRkUc/BXoEWQWiCfNepg6
         S+aCn89oGHEsZUxXAMVubukSqnzaJrdQd33JWKZUhxAbADuK8gisCM24bLHa7iu+Mdr4WS6KJIdmFD
         kLleSEaO6DYcGrRy7zG36nbmFYTTl5w==
X-HalOne-Cookie: a880fdb267b37ff9f51ca5279a5cf7ed0bab0692
X-HalOne-ID: e665811c-c39e-11ea-8888-d0431ea8a290
Received: from [192.168.0.126] (h-131-138.a357.priv.bahnhof.se [81.170.131.138])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id e665811c-c39e-11ea-8888-d0431ea8a290;
        Sat, 11 Jul 2020 17:49:43 +0000 (UTC)
Date:   Sat, 11 Jul 2020 19:49:44 +0200 (GMT+02:00)
From:   A L <mail@lechevalier.se>
To:     linux-pm@vger.kernel.org
Message-ID: <6dfd665.397441d8.1733eff4aa2@lechevalier.se>
Subject: Schedutil scaling governor is missing time_in_state
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: R2Mail2
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

I am testing the 'schedutil' scaling govenor.

So far it seems to give good results in terms of reduced thermals and energ=
y consumption.

One difference compared to 'ondemand' that I noticed is that /sys/devices/s=
ystem/cpu/cpu*/cpufreq/stats/time_in_state is never updated. It is always e=
mpty. This creates a problem for my munin graphs that log the average CPU f=
requency for each core.

Example with 'ondemand'
cpu0/cpufreq/stats/time_in_state:3500000 3869872
cpu0/cpufreq/stats/time_in_state:2300000 581995
cpu0/cpufreq/stats/time_in_state:1600000 6895937
cpu0/cpufreq/stats/total_trans:1746213
cpu0/cpufreq/stats/trans_table:=C2=A0=C2=A0 From=C2=A0 :=C2=A0=C2=A0=C2=A0 =
To
cpu0/cpufreq/stats/trans_table:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 :=C2=A0=C2=A0 3500000=C2=A0=C2=A0 2300000=C2=A0=C2=A0 1600000
cpu0/cpufreq/stats/trans_table:=C2=A0 3500000:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 49335=C2=A0=C2=A0=C2=A0=C2=
=A0 62476
cpu0/cpufreq/stats/trans_table:=C2=A0 2300000:=C2=A0=C2=A0=C2=A0=C2=A0 5821=
9=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 75685=
4
cpu0/cpufreq/stats/trans_table:=C2=A0 1600000:=C2=A0=C2=A0=C2=A0=C2=A0 5359=
1=C2=A0=C2=A0=C2=A0 765738=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
0

Example with 'schedutil'
cpu3/cpufreq/stats/time_in_state:<empty>
cpu3/cpufreq/stats/total_trans:1751092
cpu3/cpufreq/stats/trans_table:<empty>

Is this a known problem or perhaps a design choice?

This is on kernel 5.7.8 on and AMD Athlon 3000G CPU using 'acpi_cpufreq' sc=
aling_driver.

Anders

