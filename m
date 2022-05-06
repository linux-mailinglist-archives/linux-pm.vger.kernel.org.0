Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15D151D18E
	for <lists+linux-pm@lfdr.de>; Fri,  6 May 2022 08:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353408AbiEFGsB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 May 2022 02:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357536AbiEFGr7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2022 02:47:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40E666216
        for <linux-pm@vger.kernel.org>; Thu,  5 May 2022 23:44:16 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t25so10986423lfg.7
        for <linux-pm@vger.kernel.org>; Thu, 05 May 2022 23:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pN+ipm4Y08XJaeCwpFX3QHUEcl4s3svYiXXHbCPPQoU=;
        b=FvY82iSghfEEZp2oh0ikicQRh2OEyJRDckcq4kJZvbDdSMYyBn8bAnJ3Nc9MOKL5qX
         WQKx9WWSCzNC0X3VH1Mo6S6qs3pDJZ+Q4GMUXLTFOn0uuUY291+JTR8a8R6idhBoCcZv
         cXdRTHMwi5gJo+PPI9p9gK+XBsTukFzzaqWcFKTpu8DagY8Kwhr393au181DZqmVhzwS
         GRmsr0faCrflx+0FP4OlpMxoJdwYdX2pXMa4scsb+dcl1DbaqQDSIY2atl/9Ni33FzhX
         2j+NkvRlCaPLrokl17x0zhMWkOMOaSuBcLAGrGfD9XRjwofIGiQ3RcVz6ycb/Z5vJyHD
         cxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pN+ipm4Y08XJaeCwpFX3QHUEcl4s3svYiXXHbCPPQoU=;
        b=RpB519GliyCe76l0shuDAPmE3Tj8k7nu+Ye5g08NPoA6zWwVEXH6qFQkbJjym3THnT
         cKe3zCveJSdKefvR6RnbNraEStz/kqtLZdXNlW9ptdboWRbY9/7OQsvscNwA4d6dBOHP
         NsZI+wLcAYhQijSI+/7TOsCRK53/pC0guHBCx4TJ766NFPmk4Eb2fWVdtlKrp3+h0hiW
         /eo7TAs6Tq/QWr4TfnDIUXN41AUdMvT1IWROJaascz/DRWOd+BCIATmRCtVHpZKSFhkL
         HOm0+MqQM3UiYa+igudWjknke2rQwDYPm2UHA8PgHrFx99EEvysq53RP/jlZIrWZG141
         UR2w==
X-Gm-Message-State: AOAM532P0EyGXMzByxiLnFLBmwFnXeSeq3u24cQy+F5uqgLF8uQh5fHi
        PTGPhOqYspxDRdIrsroWwslN21KQsqAgZ3Vjg1JnaxeI
X-Google-Smtp-Source: ABdhPJw+o0gtCLtOVhlG/IOU1ibueUgNaI7/dFP4/fd7+xhz1JKxZdXIF7sh4MyW6R4+gCQhG2goekjkvQWe3Bc9Tro=
X-Received: by 2002:a05:6512:1191:b0:473:c7c3:f6ff with SMTP id
 g17-20020a056512119100b00473c7c3f6ffmr1470025lfr.39.1651819455034; Thu, 05
 May 2022 23:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <YnKZCGaig+EXSowf@kili>
In-Reply-To: <YnKZCGaig+EXSowf@kili>
From:   Schspa Shi <schspa@gmail.com>
Date:   Fri, 6 May 2022 14:43:59 +0800
Message-ID: <CAMA88TpC_7-S7HDnjE5VLS-h_y0pQw1Qb_Q-2DYsSDoZJLdUgQ@mail.gmail.com>
Subject: Re: [bug report] cpufreq: Fix possible race in cpufreq online error path
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> Hello Schspa Shi,
>
> The patch f346e96267cd: "cpufreq: Fix possible race in cpufreq online
> error path" from Apr 21, 2022, leads to the following Smatch static
> checker warning:
>
>       drivers/cpufreq/cpufreq.c:1545 cpufreq_online()
>       error: double unlocked '&policy->rwsem' (orig line 1340)
>
> drivers/cpufreq/cpufreq.c
>     1318 static int cpufreq_online(unsigned int cpu)
>     1319 {
>     1320         struct cpufreq_policy *policy;
>     1321         bool new_policy;
>     1322         unsigned long flags;
>     1323         unsigned int j;
>     1324         int ret;
>     1325
>     1326         pr_debug("%s: bringing CPU%u online\n", __func__, cpu);
>     1327
>     1328         /* Check if this CPU already has a policy to manage it */
>     1329         policy = per_cpu(cpufreq_cpu_data, cpu);
>     1330         if (policy) {
>     1331                 WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus));
>     1332                 if (!policy_is_inactive(policy))
>     1333                         return cpufreq_add_policy_cpu(policy, cpu);
>     1334
>     1335                 /* This is the only online CPU for the policy.  Start over. */
>     1336                 new_policy = false;
>     1337                 down_write(&policy->rwsem);
>     1338                 policy->cpu = cpu;
>     1339                 policy->governor = NULL;
>     1340                 up_write(&policy->rwsem);
>
> unlocked here
>
>     1341         } else {
>     1342                 new_policy = true;
>     1343                 policy = cpufreq_policy_alloc(cpu);
>     1344                 if (!policy)
>     1345                         return -ENOMEM;
>     1346         }
>     1347
>     1348         if (!new_policy && cpufreq_driver->online) {
>     1349                 ret = cpufreq_driver->online(policy);
>     1350                 if (ret) {
>     1351                         pr_debug("%s: %d: initialization failed\n", __func__,
>     1352                                  __LINE__);
>     1353                         goto out_exit_policy;
>
> goto
>
>     1354                 }
>     1355
>     1356                 /* Recover policy->cpus using related_cpus */
>     1357                 cpumask_copy(policy->cpus, policy->related_cpus);
>     1358         } else {
>     1359                 cpumask_copy(policy->cpus, cpumask_of(cpu));
>     1360
>     1361                 /*
>     1362                  * Call driver. From then on the cpufreq must be able
>     1363                  * to accept all calls to ->verify and ->setpolicy for this CPU.
>     1364                  */
>     1365                 ret = cpufreq_driver->init(policy);
>     1366                 if (ret) {
>     1367                         pr_debug("%s: %d: initialization failed\n", __func__,
>     1368                                  __LINE__);
>     1369                         goto out_free_policy;
>     1370                 }
>     1371
>     1372                 /*
>     1373                  * The initialization has succeeded and the policy is online.
>     1374                  * If there is a problem with its frequency table, take it
>     1375                  * offline and drop it.
>     1376                  */
>     1377                 ret = cpufreq_table_validate_and_sort(policy);
>     1378                 if (ret)
>     1379                         goto out_offline_policy;
>     1380
>     1381                 /* related_cpus should at least include policy->cpus. */
>     1382                 cpumask_copy(policy->related_cpus, policy->cpus);
>     1383         }
>     1384
>     1385         down_write(&policy->rwsem);
>     1386         /*
>     1387          * affected cpus must always be the one, which are online. We aren't
>     1388          * managing offline cpus here.
>     1389          */
>     1390         cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>     1391
>     1392         if (new_policy) {
>     1393                 for_each_cpu(j, policy->related_cpus) {
>     1394                         per_cpu(cpufreq_cpu_data, j) = policy;
>     1395                         add_cpu_dev_symlink(policy, j, get_cpu_device(j));
>     1396                 }
>     1397
>     1398                 policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
>     1399                                                GFP_KERNEL);
>     1400                 if (!policy->min_freq_req) {
>     1401                         ret = -ENOMEM;
>     1402                         goto out_destroy_policy;
>     1403                 }
>     1404
>     1405                 ret = freq_qos_add_request(&policy->constraints,
>     1406                                            policy->min_freq_req, FREQ_QOS_MIN,
>     1407                                            FREQ_QOS_MIN_DEFAULT_VALUE);
>     1408                 if (ret < 0) {
>     1409                         /*
>     1410                          * So we don't call freq_qos_remove_request() for an
>     1411                          * uninitialized request.
>     1412                          */
>     1413                         kfree(policy->min_freq_req);
>     1414                         policy->min_freq_req = NULL;
>     1415                         goto out_destroy_policy;
>     1416                 }
>     1417
>     1418                 /*
>     1419                  * This must be initialized right here to avoid calling
>     1420                  * freq_qos_remove_request() on uninitialized request in case
>     1421                  * of errors.
>     1422                  */
>     1423                 policy->max_freq_req = policy->min_freq_req + 1;
>     1424
>     1425                 ret = freq_qos_add_request(&policy->constraints,
>     1426                                            policy->max_freq_req, FREQ_QOS_MAX,
>     1427                                            FREQ_QOS_MAX_DEFAULT_VALUE);
>     1428                 if (ret < 0) {
>     1429                         policy->max_freq_req = NULL;
>     1430                         goto out_destroy_policy;
>     1431                 }
>     1432
>     1433                 blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>     1434                                 CPUFREQ_CREATE_POLICY, policy);
>     1435         }
>     1436
>     1437         if (cpufreq_driver->get && has_target()) {
>     1438                 policy->cur = cpufreq_driver->get(policy->cpu);
>     1439                 if (!policy->cur) {
>     1440                         ret = -EIO;
>     1441                         pr_err("%s: ->get() failed\n", __func__);
>     1442                         goto out_destroy_policy;
>     1443                 }
>     1444         }
>     1445
>     1446         /*
>     1447          * Sometimes boot loaders set CPU frequency to a value outside of
>     1448          * frequency table present with cpufreq core. In such cases CPU might be
>     1449          * unstable if it has to run on that frequency for long duration of time
>     1450          * and so its better to set it to a frequency which is specified in
>     1451          * freq-table. This also makes cpufreq stats inconsistent as
>     1452          * cpufreq-stats would fail to register because current frequency of CPU
>     1453          * isn't found in freq-table.
>     1454          *
>     1455          * Because we don't want this change to effect boot process badly, we go
>     1456          * for the next freq which is >= policy->cur ('cur' must be set by now,
>     1457          * otherwise we will end up setting freq to lowest of the table as 'cur'
>     1458          * is initialized to zero).
>     1459          *
>     1460          * We are passing target-freq as "policy->cur - 1" otherwise
>     1461          * __cpufreq_driver_target() would simply fail, as policy->cur will be
>     1462          * equal to target-freq.
>     1463          */
>     1464         if ((cpufreq_driver->flags & CPUFREQ_NEED_INITIAL_FREQ_CHECK)
>     1465             && has_target()) {
>     1466                 unsigned int old_freq = policy->cur;
>     1467
>     1468                 /* Are we running at unknown frequency ? */
>     1469                 ret = cpufreq_frequency_table_get_index(policy, old_freq);
>     1470                 if (ret == -EINVAL) {
>     1471                         ret = __cpufreq_driver_target(policy, old_freq - 1,
>     1472                                                       CPUFREQ_RELATION_L);
>     1473
>     1474                         /*
>     1475                          * Reaching here after boot in a few seconds may not
>     1476                          * mean that system will remain stable at "unknown"
>     1477                          * frequency for longer duration. Hence, a BUG_ON().
>     1478                          */
>     1479                         BUG_ON(ret);
>     1480                         pr_info("%s: CPU%d: Running at unlisted initial frequency: %u KHz, changing to: %u KHz\n",
>     1481                                 __func__, policy->cpu, old_freq, policy->cur);
>     1482                 }
>     1483         }
>     1484
>     1485         if (new_policy) {
>     1486                 ret = cpufreq_add_dev_interface(policy);
>     1487                 if (ret)
>     1488                         goto out_destroy_policy;
>     1489
>     1490                 cpufreq_stats_create_table(policy);
>     1491
>     1492                 write_lock_irqsave(&cpufreq_driver_lock, flags);
>     1493                 list_add(&policy->policy_list, &cpufreq_policy_list);
>     1494                 write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>     1495
>     1496                 /*
>     1497                  * Register with the energy model before
>     1498                  * sched_cpufreq_governor_change() is called, which will result
>     1499                  * in rebuilding of the sched domains, which should only be done
>     1500                  * once the energy model is properly initialized for the policy
>     1501                  * first.
>     1502                  *
>     1503                  * Also, this should be called before the policy is registered
>     1504                  * with cooling framework.
>     1505                  */
>     1506                 if (cpufreq_driver->register_em)
>     1507                         cpufreq_driver->register_em(policy);
>     1508         }
>     1509
>     1510         ret = cpufreq_init_policy(policy);
>     1511         if (ret) {
>     1512                 pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
>     1513                        __func__, cpu, ret);
>     1514                 goto out_destroy_policy;
>     1515         }
>     1516
>     1517         up_write(&policy->rwsem);
>     1518
>     1519         kobject_uevent(&policy->kobj, KOBJ_ADD);
>     1520
>     1521         /* Callback for handling stuff after policy is ready */
>     1522         if (cpufreq_driver->ready)
>     1523                 cpufreq_driver->ready(policy);
>     1524
>     1525         if (cpufreq_thermal_control_enabled(cpufreq_driver))
>     1526                 policy->cdev = of_cpufreq_cooling_register(policy);
>     1527
>     1528         pr_debug("initialization complete\n");
>     1529
>     1530         return 0;
>     1531
>     1532 out_destroy_policy:
>     1533         for_each_cpu(j, policy->real_cpus)
>     1534                 remove_cpu_dev_symlink(policy, get_cpu_device(j));
>     1535
>     1536 out_offline_policy:
>     1537         if (cpufreq_driver->offline)
>     1538                 cpufreq_driver->offline(policy);
>     1539
>     1540 out_exit_policy:
>     1541         if (cpufreq_driver->exit)
>     1542                 cpufreq_driver->exit(policy);
>     1543
>     1544         cpumask_clear(policy->cpus);
> --> 1545         up_write(&policy->rwsem);
>
> Double unlock

Thanks for pointing out this double unlock, do you want to fix it by yourself?
Or I will fix it.

>
>     1546
>     1547 out_free_policy:
>     1548         cpufreq_policy_free(policy);
>     1549         return ret;
>     1550 }
>
> regards,
> dan carpenter

---
BRs
Schspa Shi
