Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD3B5B8163
	for <lists+linux-pm@lfdr.de>; Wed, 14 Sep 2022 08:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiINGMb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Sep 2022 02:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiINGMC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Sep 2022 02:12:02 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E5371BD6;
        Tue, 13 Sep 2022 23:11:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+8tBUFAmE5HsCLayoiC6MBvebr+PVElJ6cvK77QWs2ofUmZrpdwfZO2AB2cLPDchZ3JsO+WgDqYOJSXgAgFTyHHf9FnjQudA0GsfOwNCUl9jUauKQKjqPAcqVcm9rJL3J+lymxdIkvN6/N4Z98EQkSvMYnfAn84128BY1fQfPxyiSiZCwCz4cirNLTOXl2EKlRmDrNC/eLW19bNghG4jXLlZScGpdI2tfQmXAppZWKxFY1++W8Zz8Nv88L0uQAIhEv+AkqEDsgasWPlGC0IzNXYV6WP0lJ4LGyGYlk9A2SKEgLtw9PNtL0b49wkV+aawTXG4+QDDI4BNSEx3cnl3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4ptKBh6XoQ5HhgavaFoUFWjxEZVFER3zBu4xG1QEJw=;
 b=oUxeTpqz5B7OEHDlX8jhcmTAc0D80gKtPgotkMTCA1RJyZ3Vxa69PidoBbsXEEC15lcgaWqaTLfat4ivycccol/oVCyG8j4K55+3GqVDRY/hnNUaQoHq1hkgAHOPIm6AL51CTBmlKR1rz5RyT8HHGC5tLHrIyWtYtLOXuGsjwEcENaownXU8ZedhvoyIRLJ0K6EvcRkU2m200TxyPi47mS4NxawbfI+pMMiUqHw64xJLUz9nBS/YdFRoZvvDi//RuQV3JDmIyaEGN7QxdkBK016JNBJHMZE2auQJz/d5I9L/5RXvdrNb+J6EbWgEyC9txzxi9agK918GtIsax6ELlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4ptKBh6XoQ5HhgavaFoUFWjxEZVFER3zBu4xG1QEJw=;
 b=x680C79KpEVD2Gv7bDd6erjTzslLs52Ton17ZV3tTxmiauklsVr3jTjhcK4QDv4vuNbJvuSxRC8G1uOmzMDvNPs/RXzx81fgH9p4hP2VUDr3vHJiJYS7OcjVhJKPn+ax7C+Dq8h2u3uoAzICL/rceLSo+oaAuAczMV73OBU1Gyg=
Received: from DS7PR05CA0090.namprd05.prod.outlook.com (2603:10b6:8:56::13) by
 BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 14 Sep
 2022 06:11:49 +0000
Received: from DS1PEPF0000B079.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::3f) by DS7PR05CA0090.outlook.office365.com
 (2603:10b6:8:56::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.6 via Frontend
 Transport; Wed, 14 Sep 2022 06:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B079.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.10 via Frontend Transport; Wed, 14 Sep 2022 06:11:48 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 01:11:44 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH V3 4/4] Documentation: amd-pstate: Add tbench and gitsource test introduction
Date:   Wed, 14 Sep 2022 14:11:05 +0800
Message-ID: <20220914061105.1982477-5-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220914061105.1982477-1-li.meng@amd.com>
References: <20220914061105.1982477-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B079:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ffe40b-c1f4-4095-ea27-08da96180257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ans5hAC9h/fLApGGMcIPwioboKnpO14poupwY56q6TfFbP6cbRng8nfu9Mf/za6oa+ND+N31FEOlKC2yxSFD6htgmCO4sK6O5uns7fO1buolyvzpV9Q37DU1JjsdjnVu3pU65C1i0Yt+RsjeBYZ/Lj94JbVLD7MW7faLmZmigC+ldcAQ6xl+3cjqjd7FoRwI4k3u4XLfxJB7z+h1DuOzUjMR5srAHdIhLCg0XmL1mKMrDaWfg3Cgn3FpNkLwN5JoEJKShQDHm01mg3Y/fQMMD4jx7/GRf0HhmOHvLCJo8L23gD5h4jcqh3z3xLXc+/OwXcAO4qHWp/HazdjEHB69137rAGZbVXlZEOQ6AAuVInTlK1phniVURcUbO1I5DRoEaaDmKssRlAq/6oBOGPEt6oaTkvq8wmrS/Tdqo0T6QozCbIIZwFgrzrdNKQQWRKfMq/RabYQkgiygyYfS+seqigaZmnLuxAF1Cvy795fp4LqSRrnmeh8do+QV8c/2F0u0ZDuh8O6yHT9zTOnqYYmYIbtE3dyUbNI3wL35RNui3wM332ZIYjFACR2RsmESejfDx2fF66gR32tZu+y8PNfmbDayarHLO53B+WHJgwz2GgijyUHf2RiLNR1Qa7/5K1QTVai0b4VPEuMCCQCOZadMVl1VB5ycmQ9zs8UjClO3Fw5YEzbHOIm2ZnmWOZKXksroLJIpSpxOmURQw3TtdKeFpwEyRyOhO43tUH8N4NTGLgBRfEWc9R9UDyv9SaJzbP493NWIcmtXhutiE4YZZ/9+861pK4yOQN/wZK+5AFSVLabyuOO8admGpyuNcdsYHHDI
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(46966006)(36840700001)(40470700004)(16526019)(2616005)(41300700001)(186003)(110136005)(47076005)(5660300002)(36756003)(40460700003)(7696005)(8936002)(83380400001)(70206006)(356005)(2906002)(82740400003)(40480700001)(1076003)(54906003)(336012)(30864003)(478600001)(26005)(426003)(36860700001)(6666004)(70586007)(4326008)(81166007)(82310400005)(316002)(86362001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 06:11:48.8106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ffe40b-c1f4-4095-ea27-08da96180257
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B079.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce tbench and gitsource test cases design and implementation.
Monitor cpus changes about performance and power consumption etc.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 192 ++++++++++++++++++--
 1 file changed, 173 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 8f3d30c5a0d8..6dda74ad717c 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -409,37 +409,55 @@ Unit Tests for amd-pstate
 
 1. Test case decriptions
 
+    1). basic tests
+
+        Test prerequisite and basic functions for the ``amd-pstate`` driver.
+
         +---------+--------------------------------+------------------------------------------------------------------------------------+
         | Index   | Functions                      | Description                                                                        |
         +=========+================================+====================================================================================+
-        | 0       | amd_pstate_ut_acpi_cpc_valid   || Check whether the _CPC object is present in SBIOS.                                |
+        | 1       | amd_pstate_ut_acpi_cpc_valid   || Check whether the _CPC object is present in SBIOS.                                |
         |         |                                ||                                                                                   |
         |         |                                || The detail refer to `Processor Support <processor_support_>`_.                    |
         +---------+--------------------------------+------------------------------------------------------------------------------------+
-        | 1       | amd_pstate_ut_check_enabled    || Check whether AMD P-State is enabled.                                             |
+        | 2       | amd_pstate_ut_check_enabled    || Check whether AMD P-State is enabled.                                             |
         |         |                                ||                                                                                   |
         |         |                                || AMD P-States and ACPI hardware P-States always can be supported in one processor. |
         |         |                                | But AMD P-States has the higher priority and if it is enabled with                 |
         |         |                                | :c:macro:`MSR_AMD_CPPC_ENABLE` or ``cppc_set_enable``, it will respond to the      |
         |         |                                | request from AMD P-States.                                                         |
         +---------+--------------------------------+------------------------------------------------------------------------------------+
-        | 2       | amd_pstate_ut_check_perf       || Check if the each performance values are reasonable.                              |
+        | 3       | amd_pstate_ut_check_perf       || Check if the each performance values are reasonable.                              |
         |         |                                || highest_perf >= nominal_perf > lowest_nonlinear_perf > lowest_perf > 0.           |
         +---------+--------------------------------+------------------------------------------------------------------------------------+
-        | 3       | amd_pstate_ut_check_freq       || Check if the each frequency values and max freq when set support boost mode       |
+        | 4       | amd_pstate_ut_check_freq       || Check if the each frequency values and max freq when set support boost mode       |
         |         |                                | are reasonable.                                                                    |
         |         |                                || max_freq >= nominal_freq > lowest_nonlinear_freq > min_freq > 0                   |
         |         |                                || If boost is not active but supported, this maximum frequency will be larger than  |
         |         |                                | the one in ``cpuinfo``.                                                            |
         +---------+--------------------------------+------------------------------------------------------------------------------------+
 
+    2). Tbench test
+
+        Test and monitor the cpu changes when running tbench benchmark under the specified governor.
+        These changes include desire performance, frequency, load, performance, energy etc.
+        The specified governor is ondemand or schedutil.
+        Tbench can also be tested on the acpi-cpufreq kernel driver for comparison.
+
+    3). Gitsource test
+
+        Test and monitor the cpu changes when running gitsource benchmark under the specified governor.
+        These changes include desire performance, frequency, load, time, energy etc.
+        The specified governor is ondemand or schedutil.
+        Gitsource can also be tested on the acpi-cpufreq kernel driver for comparison.
+
 #. How to execute the tests
 
    We use test module in the kselftest frameworks to implement it.
    We create amd-pstate-ut module and tie it into kselftest.(for
    details refer to Linux Kernel Selftests [4]_).
 
-    1. Build
+    1). Build
 
         + open the :c:macro:`CONFIG_X86_AMD_PSTATE` configuration option.
         + set the :c:macro:`CONFIG_X86_AMD_PSTATE_UT` configuration option to M.
@@ -449,23 +467,159 @@ Unit Tests for amd-pstate
             $ cd linux
             $ make -C tools/testing/selftests
 
-    #. Installation & Steps ::
+        + make perf ::
+
+            $ cd tools/perf/
+            $ make
+
+
+    2). Installation & Steps ::
 
         $ make -C tools/testing/selftests install INSTALL_PATH=~/kselftest
+        $ cp tools/perf/perf /user/bin/perf
         $ sudo ./kselftest/run_kselftest.sh -c amd-pstate
-        TAP version 13
-        1..1
-        # selftests: amd-pstate: amd-pstate-ut.sh
-        # amd-pstate-ut: ok
-        ok 1 selftests: amd-pstate: amd-pstate-ut.sh
-
-    #. Results ::
-
-         $ dmesg | grep "amd_pstate_ut" | tee log.txt
-         [12977.570663] amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
-         [12977.570673] amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
-         [12977.571207] amd_pstate_ut: 3    amd_pstate_ut_check_perf      success!
-         [12977.571212] amd_pstate_ut: 4    amd_pstate_ut_check_freq      success!
+
+    3). Specified test case ::
+
+        $ cd ~/kselftest/amd-pstate
+        $ sudo ./run.sh -t basic
+        $ sudo ./run.sh -t tbench
+        $ sudo ./run.sh -t tbench -m acpi-cpufreq
+        $ sudo ./run.sh -t gitsource
+        $ sudo ./run.sh -t gitsource -m acpi-cpufreq
+        $ ./run.sh --help
+        ./run.sh: illegal option -- -
+        Usage: ./run.sh [OPTION...]
+                [-h <help>]
+                [-o <output-file-for-dump>]
+                [-c <all: All testing,
+                     basic: Basic testing,
+                     tbench: Tbench testing,
+                     gitsource: Gitsource testing.>]
+                [-t <tbench time limit>]
+                [-p <tbench process number>]
+                [-l <loop times for tbench>]
+                [-i <amd tracer interval>]
+                [-m <comparative test: acpi-cpufreq>]
+
+
+    4). Results
+
+        + basic
+
+         When you finish test, you will get the following log info ::
+
+          $ dmesg | grep "amd_pstate_ut" | tee log.txt
+          [12977.570663] amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
+          [12977.570673] amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
+          [12977.571207] amd_pstate_ut: 3    amd_pstate_ut_check_perf      success!
+          [12977.571212] amd_pstate_ut: 4    amd_pstate_ut_check_freq      success!
+
+        + tbench
+
+         When you finish test, you will get selftest.tbench.csv and png images.
+         The selftest.tbench.csv file contains the raw data and the drop of the comparative test.
+         The png images shows the performance, energy and performan per watt of each test.
+         Open selftest.tbench.csv :
+
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + Governor                                        | Round        | Des-perf | Freq    | Load     | Performance | Energy  | Performance Per Watt |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + Unit                                            |              |          | GHz     |          | MB/s        | J       | MB/J                 |
+         +=================================================+==============+==========+=========+==========+=============+=========+======================+
+         + amd-pstate-ondemand                             | 1            |          |         |          | 2504.05     | 1563.67 | 158.5378             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + amd-pstate-ondemand                             | 2            |          |         |          | 2243.64     | 1430.32 | 155.2941             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + amd-pstate-ondemand                             | 3            |          |         |          | 2183.88     | 1401.32 | 154.2860             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + amd-pstate-ondemand                             | Average      |          |         |          | 2310.52     | 1465.1  | 156.1268             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | 1            | 165.329  | 1.62257 | 99.798   | 2136.54     | 1395.26 | 151.5971             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | 2            | 166      | 1.49761 | 99.9993  | 2100.56     | 1380.5  | 150.6377             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | 3            | 166      | 1.47806 | 99.9993  | 2084.12     | 1375.76 | 149.9737             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | Average      | 165.776  | 1.53275 | 99.9322  | 2107.07     | 1383.84 | 150.7399             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | 1            |          |         |          | 2529.9      | 1564.4  | 160.0997             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | 2            |          |         |          | 2249.76     | 1432.97 | 155.4297             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | 3            |          |         |          | 2181.46     | 1406.88 | 153.5060             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | Average      |          |         |          | 2320.37     | 1468.08 | 156.4741             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | 1            |          |         |          | 2137.64     | 1385.24 | 152.7723             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | 2            |          |         |          | 2107.05     | 1372.23 | 152.0138             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | 3            |          |         |          | 2085.86     | 1365.35 | 151.2433             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | Average      |          |         |          | 2110.18     | 1374.27 | 152.0136             |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand VS acpi-cpufreq-schedutil | Comprison(%) |          |         |          | -9.0584     | -6.3899 | -2.8506              |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + amd-pstate-ondemand VS amd-pstate-schedutil     | Comprison(%) |          |         |          | 8.8053      | -5.5463 | -3.4503              |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand VS amd-pstate-ondemand    | Comprison(%) |          |         |          | -0.4245     | -0.2029 | -0.2219              |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil VS amd-pstate-schedutil  | Comprison(%) |          |         |          | -0.1473     | 0.6963  | -0.8378              |
+         +-------------------------------------------------+--------------+----------+---------+----------+-------------+---------+----------------------+
+
+        + gitsource
+
+         When you finish test, you will get selftest.gitsource.csv and png images.
+         The selftest.gitsource.csv file contains the raw data and the drop of the comparative test.
+         The png images shows the performance, energy and performan per watt of each test.
+         Open selftest.gitsource.csv :
+
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + Governor                                        | Round        | Des-perf | Freq     | Load     | Time        | Energy  | Performance Per Watt |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + Unit                                            |              |          | GHz      |          | s           | J       | 1/J                  |
+         +=================================================+==============+==========+==========+==========+=============+=========+======================+
+         + amd-pstate-ondemand                             | 1            | 50.119   | 2.10509  | 23.3076  | 475.69      | 865.78  | 0.001155027          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + amd-pstate-ondemand                             | 2            | 94.8006  | 1.98771  | 56.6533  | 467.1       | 839.67  | 0.001190944          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + amd-pstate-ondemand                             | 3            | 76.6091  | 2.53251  | 43.7791  | 467.69      | 855.85  | 0.001168429          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + amd-pstate-ondemand                             | Average      | 73.8429  | 2.20844  | 41.2467  | 470.16      | 853.767 | 0.001171279          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | 1            | 165.919  | 1.62319  | 98.3868  | 464.17      | 866.8   | 0.001153668          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | 2            | 165.97   | 1.31309  | 99.5712  | 480.15      | 880.4   | 0.001135847          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | 3            | 165.973  | 1.28448  | 99.9252  | 481.79      | 867.02  | 0.001153375          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + amd-pstate-schedutil                            | Average      | 165.954  | 1.40692  | 99.2944  | 475.37      | 871.407 | 0.001147569          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | 1            |          |          |          | 2379.62     | 742.96  | 0.001345967          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | 2            |          |          |          | 441.74      | 817.49  | 0.001223256          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | 3            |          |          |          | 455.48      | 820.01  | 0.001219497          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand                           | Average      |          |          |          | 425.613     | 793.487 | 0.001260260          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | 1            |          |          |          | 459.69      | 838.54  | 0.001192548          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | 2            |          |          |          | 466.55      | 830.89  | 0.001203528          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | 3            |          |          |          | 470.38      | 837.32  | 0.001194286          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil                          | Average      |          |          |          | 465.54      | 835.583 | 0.001196769          |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand VS acpi-cpufreq-schedutil | Comprison(%) |          |          |          | 9.3810      | 5.3051  | -5.0379              |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + amd-pstate-ondemand VS amd-pstate-schedutil     | Comprison(%) | 124.7392 | -36.2934 | 140.7329 | 1.1081      | 2.0661  | -2.0242              |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-ondemand VS amd-pstate-ondemand    | Comprison(%) |          |          |          | 10.4665     | 7.5968  | -7.0605              |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
+         + acpi-cpufreq-schedutil VS amd-pstate-schedutil  | Comprison(%) |          |          |          | 2.1115      | 4.2873  | -4.1110              |
+         +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
 
 Reference
 ===========
-- 
2.34.1

