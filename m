Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BC71CDCB2
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 16:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbgEKOLN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 10:11:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730180AbgEKOLN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 10:11:13 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BDZpr5187561;
        Mon, 11 May 2020 10:11:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30wrvyen0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 10:11:04 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04BDa2u9188832;
        Mon, 11 May 2020 10:11:03 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30wrvyemy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 10:11:03 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04BEB1XN003437;
        Mon, 11 May 2020 14:11:01 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 30wm569trr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 14:11:01 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04BEAwCC45941214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 14:10:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 612ED52052;
        Mon, 11 May 2020 14:10:58 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.199.59.41])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 390B552051;
        Mon, 11 May 2020 14:10:56 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, peterz@infradead.org,
        dsmythies@telus.net, daniel.lezcano@linaro.org,
        ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        psampat@linux.ibm.com, pratik.sampat@in.ibm.com,
        pratik.r.sampat@gmail.com
Subject: [RFC 0/1] Alternate history mechanism for the TEO governor
Date:   Mon, 11 May 2020 19:40:54 +0530
Message-Id: <20200511141055.43029-1-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_06:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110112
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

First RFC posting: https://lkml.org/lkml/2020/2/22/27
Changelog
1. Upated benchmarks

Currently the TEO governor apart from the TEO timer and hit/miss/early
hit buckets; especially for non-timer events, also gathers history of 8
intervals and if there are significant idle durations less than the
current, then it decides if a shallower state must be chosen.
 
The current sliding history window does do fair job for the prediction
of the non-timer events, so to improve upon the history mechanism,
one may just hypothesize increasing the interval window so that more
history can influence better decisions.

However, this may not be true. The current algorithm can be limited due
to its linearity, while also average of interval durations may not be a
suitable metric when the data presents skewness. This can especially be
true for the when number of intervals taken into account increases.

Benchmark: Schbench
Provides latency statistics for scheduler wakeups
Machine - IBM Power 9

Metric of measurement
1. Performance - latency 99th percentile - usec
2. Power - watts
Performance and Power statistics are normalized

Latency - Normalized
8 intervals is baseline
+---------+-------------+--------------+--------------+--------------+
| Threads | 8 Intervals | 16 Intervals | 32 Intervals | 64 Intervals |
+---------+-------------+--------------+--------------+--------------+
| 2       | 100         | 102.81       | 106.93       | 100.86       |
+---------+-------------+--------------+--------------+--------------+
| 4       | 100         | 104.67       | 96.58        | 96.58        |
+---------+-------------+--------------+--------------+--------------+
| 8       | 100         | 116.26       | 100          | 121.44       |
+---------+-------------+--------------+--------------+--------------+
| 16      | 100         | 85.94        | 81.46        | 80.86        |
+---------+-------------+--------------+--------------+--------------+
+---------+---------------+
| Threads | 128 Intervals |
+---------+---------------+
| 2       | 83.09         |
+---------+---------------+
| 4       | 74.75         |
+---------+---------------+
| 8       | 87.15         |
+---------+---------------+
| 16      | 76.98         |
+---------+---------------+

The latency number are kind of a mixed bag. Some intervals perform
similar, while some slightly better, while some considerably worse

Standout: 128 latency intervals always performs well in terms of latency

Power - Normalized
8 intervals in baseline
+---------+-------------+--------------+--------------+--------------+
| Threads | 8 Intervals | 16 Intervals | 32 Intervals | 64 Intervals |
+---------+-------------+--------------+--------------+--------------+
| 2       | 100         | 100          | 85.29        | 97.05        |
+---------+-------------+--------------+--------------+--------------+
| 4       | 100         | 115.9        | 111.36       | 145.45       |
+---------+-------------+--------------+--------------+--------------+
| 8       | 100         | 109.63       | 114.45       | 102.4        |
+---------+-------------+--------------+--------------+--------------+
| 16      | 100         | 104.2        | 103.36       | 102.52       |
+---------+-------------+--------------+--------------+--------------+
+---------+---------------+
| Threads | 128 Intervals |
+---------+---------------+
| 2       | 123.52        |
+---------+---------------+
| 4       | 159.09        |
+---------+---------------+
| 8       | 114.45        |
+---------+---------------+
| 16      | 106.72        |
+---------+---------------+

Power considerably regresses in almost all cases, showing that with
increasing history there seems to be skewness presented to shallow
states.

Weighted TEO Governor
---------------------

To complement the current moving window history, an approach is devised
where each idle state separately maintains a weight for itself and its
counterpart idle states to form a probability distribution.

When a decision needs to be made, the TEO governor selects an idle state
based on its timer and other hits/early hits metric. After which, the
probability distribution of that selected idle state is looked at which
gives insight into how probable that state is to occur if picked.

The probability distribution is nothing but a n*n matrix, where
n - drv->state_count.
Each entry in the array signifies a weight for that row.
The weights can vary from the range [0-10000].

For example:
state_mat[2][1] - 3000 means that when state 2 is entered idle with, the
probability that the interval will last long enough to satisfy state 1's
residency is 30%.
The trailing zeros correspond to having more resolution while increasing
or reducing the weights for correction.

Currently, for selection of an idle state based on probabilities, a
weighted random number generator is used to choose one of the idle
states. Naturally, the states with higher weights are more likely to be
chosen.

On wakeup, the weights are updated. The state with which it should have
woken up with (could be the hit / miss / early hit state) is increased
in weight by the "LEARNING_RATE" % and the rest of the states for that
index are reduced by the same factor.

A possible disadvantage of this approach is that history for that
thread may make the weights stale and influence the choosing of idle
states which may not be relevant anymore. Aging the weights could be a
solution for that, where over time, the highest weight for that index
can be decayed and the weight equally spread across the rest of the
states.
Although this RFC does not cover the implementation for that as there
seemed to be too much run to run variance with this approach.

Having a finer view of the history in addition to weighted randomized
salt seems to show some promise in terms of saving power without
compromising performance.

Why not just pick the state with the highest probability?
- If there are multiple states close in probabilities competing for
dominance they should be given a fair chance
Of course, if the prediction was wrong the algorithm will self correct,
however by that time the pattern may have changed
- If this contention pattern is exhibited often then the prediction
algorithm will always stay playing catch-up. 

Benchmarks:

Metric of measurement:
1. Performance (latency / throughput)
2. Power (watts)
3. Accuracy %
  a. Correct prediction - The idle state predicted aligns with the
     actual sleep duration
  b. Undershoot prediction (US) - The idle state predicted is deeper for
     the actual sleep duration
  c. Overshoot prediction (OS) - The idle state predicted is shallower
     for the actual sleep duration

Performance and Power numbers are normalized.
However accuracy numbers are deliberately kept as-is to show how well
the vanilla governor performed in the first place

Schbench
--------
Benchmarks scheduler wakeup latencies

1. latency 99th percentile - usec
2. Power - watts
Machine - IBM Power 9

Latency and Power - Normalized
+---------+--------------+-----------------+---------------+
| Threads | TEO Baseline | Wt. TEO Latency | Wt. TEO Power |
+---------+--------------+-----------------+---------------+
| 2       | 100          | 101.3           | 85.29         |
+---------+--------------+-----------------+---------------+
| 4       | 100          | 105.06          | 113.63        |
+---------+--------------+-----------------+---------------+
| 8       | 100          | 92.32           | 90.36         |
+---------+--------------+-----------------+---------------+
| 16      | 100          | 99.1            | 92.43         |
+---------+--------------+-----------------+---------------+

Accuracy

Vanilla TEO Governor - Prediction distribution %
+---------+------+------+------+-------+-------+-------+---------+
| Threads | US 1 | US 2 | US 3 | US 4  | US 5  | US 6  | Correct |
+---------+------+------+------+-------+-------+-------+---------+
| 2       | 6.12 | 1.08 | 1.76 | 20.41 | 9.2   | 28.74 | 22.51   |
+---------+------+------+------+-------+-------+-------+---------+
| 4       | 8.54 | 1.56 | 1.25 | 20.24 | 10.75 | 25.17 | 22.67   |
+---------+------+------+------+-------+-------+-------+---------+
| 8       | 5.88 | 2.67 | 1.09 | 13.72 | 17.08 | 32.04 | 22.95   |
+---------+------+------+------+-------+-------+-------+---------+
| 16      | 6.29 | 2.43 | 0.86 | 13.21 | 15.33 | 26.52 | 29.34   |
+---------+------+------+------+-------+-------+-------+---------+
+---------+------+------+------+
| Threads | OS 1 | OS 2 | OS 3 |
+---------+------+------+------+
| 2       | 1.77 | 1.27 | 7.14 |
+---------+------+------+------+
| 4       | 1.8  | 1.31 | 6.71 |
+---------+------+------+------+
| 8       | 0.65 | 0.72 | 3.2  |
+---------+------+------+------+
| 16      | 0.63 | 1.71 | 3.68 |
+---------+------+------+------+

Weighted TEO Governor - Prediction distribution %
+---------+------+------+------+-------+-------+-------+---------+
| Threads | US 1 | US 2 | US 3 | US 4  | US 5  | US 6  | Correct |
+---------+------+------+------+-------+-------+-------+---------+
| 2       | 7.26 | 2.07 | 0.02 | 15.85 | 13.29 | 36.26 | 22.13   |
+---------+------+------+------+-------+-------+-------+---------+
| 4       | 4.33 | 1.45 | 0.15 | 14.17 | 14.68 | 40.36 | 21.01   |
+---------+------+------+------+-------+-------+-------+---------+
| 8       | 4.73 | 2.46 | 0.12 | 12.48 | 14.68 | 32.38 | 28.9    |
+---------+------+------+------+-------+-------+-------+---------+
| 16      | 7.68 | 1.25 | 0.98 | 12.15 | 11.19 | 24.91 | 35.92   |
+---------+------+------+------+-------+-------+-------+---------+
+---------+------+------+------+
| Threads | OS 1 | OS 2 | OS 3 |
+---------+------+------+------+
| 2       | 0.39 | 0.42 | 2.31 |
+---------+------+------+------+
| 4       | 0.45 | 0.51 | 2.89 |
+---------+------+------+------+
| 8       | 0.53 | 0.66 | 3.06 |
+---------+------+------+------+
| 16      | 0.97 | 1.9  | 3.05 |
+---------+------+------+------+

Sleeping Ebizzy
---------------
Program to generate workloads resembling web server workloads.
The benchmark is customized to allow for a sleep interval -i

1. Number of records
2. Power - watts
Machine - IBM Power 9

Parameters:
1. -m -> Always use mmap instead of malloc
2. -M -> Never use mmap
3. -S <seconds> -> Number of seconds to run
4. -i <interval> -> Sleep interval

Number of records and power normalized
+-------------------+---------------+------------------+-----------------+
| Parameters        | TEO baseline  | Wt TEO records   | Wt. TEO Power   |
+-------------------+---------------+------------------+-----------------+
| -S 60 -i 10000    | 100           | 106.56           | 93.95           |
+-------------------+---------------+------------------+-----------------+
| -m -S 60 -i 10000 | 100           | 100.62           | 82.14           |
+-------------------+---------------+------------------+-----------------+
| -M -S 60 -i 10000 | 100           | 104.97           | 95.19           |
+-------------------+---------------+------------------+-----------------+

Accuracy

Vanilla TEO Governor - Prediction distribution %
+-------------------+-------+------+------+-------+------+-------+
| Parameters        | US 1  | US 2 | US 3 | US 4  | US 5 | US 6  |
+-------------------+-------+------+------+-------+------+-------+
| -S 60 -i 10000    | 45.46 | 0.52 | 1.5  | 15.34 | 2.44 | 8.61  |
+-------------------+-------+------+------+-------+------+-------+
| -m -S 60 -i 10000 | 4.22  | 2.08 | 0.71 | 90.01 | 0    | 0.01  |
+-------------------+-------+------+------+-------+------+-------+
| -M -S 60 -i 10000 | 15.78 | 1.42 | 2.4  | 22.39 | 1.68 | 11.25 |
+-------------------+-------+------+------+-------+------+-------+
+-------------------+---------+------+------+------+------+
| Parameters        | Correct | OS 1 | OS 2 | OS 3 | OS 4 |
+-------------------+---------+------+------+------+------+
| -S 60 -i 10000    | 17.03   | 1.73 | 1.1  | 6.27 | 0    |
+-------------------+---------+------+------+------+------+
| -m -S 60 -i 10000 | 2.44    | 0.18 | 0.13 | 0.22 | 0    |
+-------------------+---------+------+------+------+------+
| -M -S 60 -i 10000 | 31.65   | 3.45 | 1.8  | 8.18 | 0    |
+-------------------+---------+------+------+------+------+

Weigted TEO Governor - Prediction distribution %
+-------------------+-------+------+------+-------+------+-------+
| Parameters        | US 1  | US 2 | US 3 | US 4  | US 5 | US 6  |
+-------------------+-------+------+------+-------+------+-------+
| -S 60 -i 10000    | 8.25  | 0.87 | 0.98 | 19.23 | 4.05 | 26.35 |
+-------------------+-------+------+------+-------+------+-------+
| -m -S 60 -i 10000 | 7.69  | 4.35 | 0.93 | 82.74 | 0.01 | 0.01  |
+-------------------+-------+------+------+-------+------+-------+
| -M -S 60 -i 10000 | 3.73  | 3.29 | 0.73 | 13.33 | 7.38 | 18.61 |
+-------------------+-------+------+------+-------+------+-------+
+-------------------+---------+------+------+------+------+
| Parameters        | Correct | OS 1 | OS 2 | OS 3 | OS 4 |
+-------------------+---------+------+------+------+------+
| -S 60 -i 10000    | 32.86   | 3.27 | 2.05 | 2.09 | 0    |
+-------------------+---------+------+------+------+------+
| -m -S 60 -i 10000 | 3.4     | 0.29 | 0.28 | 0.3  | 0    |
+-------------------+---------+------+------+------+------+
| -M -S 60 -i 10000 | 48.19   | 1.8  | 0.93 | 1.97 | 0.04 |
+-------------------+---------+------+------+------+------+

Pgbench
-------
pgbench is a simple program for running benchmark tests on PostgreSQL.
It runs the same sequence of SQL commands over and over, possibly in
multiple concurrent database sessions, and then calculates the average
transaction rate (transactions per second).
Scale of measurement:
1. Number of transactions
2. Power (watts)
Machine - IBM Power 9

Number of transactions and power is normalized

+---------+---------------+---------------------+-----------------+
| Clients | TEO Baseline  | Wt. TEO transations | Wt. TEO power   |
+---------+---------------+---------------------+-----------------+
| 4       | 100           | 105.93              | 85.18           |
+---------+---------------+---------------------+-----------------+
| 8       | 100           | 98.11               | 100             |
+---------+---------------+---------------------+-----------------+
| 16      | 100           | 98.73               | 104.16          |
+---------+---------------+---------------------+-----------------+
| 32      | 100           | 101.05              | 95              |
+---------+---------------+---------------------+-----------------+

Accuracy

Vanilla TEO Governor - Prediction distribution %
+---------+-------+-------+-------+-------+------+------+---------+
| Clients | US 1  | US 2  | US 3  | US 4  | US 5 | US 6 | Correct |
+---------+-------+-------+-------+-------+------+------+---------+
| 4       | 59.97 | 2.56  | 0.46  | 1.45  | 0.13 | 0.87 | 32.09   |
+---------+-------+-------+-------+-------+------+------+---------+
| 8       | 82.76 | 7.31  | 0.12  | 1.23  | 0.08 | 1.22 | 7.2     |
+---------+-------+-------+-------+-------+------+------+---------+
| 16      | 2     | 13.46 | 73.27 | 10.7  | 0.04 | 0.12 | 0.38    |
+---------+-------+-------+-------+-------+------+------+---------+
| 32      | 1.33  | 0.76  | 44.9  | 40.8  | 0.07 | 12   | 0.12    |
+---------+-------+-------+-------+-------+------+------+---------+
+---------+------+------+------+
| Clients | OS 1 | OS 2 | OS 3 |
+---------+------+------+------+
| 4       | 2.44 | 0.01 | 0.02 |
+---------+------+------+------+
| 8       | 0.04 | 0.02 | 0.02 |
+---------+------+------+------+
| 16      | 0.02 | 0    | 0.01 |
+---------+------+------+------+
| 32      | 0.02 | 0    | 0    |
+---------+------+------+------+

Weigted TEO Governor - Prediction distribution %
+---------+-------+-------+-------+-------+------+------+---------+
| Clients | US 1  | US 2  | US 3  | US 4  | US 5 | US 6 | Correct |
+---------+-------+-------+-------+-------+------+------+---------+
| 4       | 42.79 | 1.79  | 0.01  | 0.72  | 0.1  | 0.78 | 46.99   |
+---------+-------+-------+-------+-------+------+------+---------+
| 8       | 76.52 | 8.02  | 0.12  | 0.42  | 0.06 | 0.5  | 14.35   |
+---------+-------+-------+-------+-------+------+------+---------+
| 16      | 0.72  | 51.95 | 42.02 | 4.65  | 0.05 | 0.31 | 0.3     |
+---------+-------+-------+-------+-------+------+------+---------+
| 32      | 1.06  | 1.59  | 42.89 | 53.11 | 0.05 | 0.42 | 0.87    |
+---------+-------+-------+-------+-------+------+------+---------+
+---------+------+------+------+
| Clients | OS 1 | OS 2 | OS 3 |
+---------+------+------+------+
| 4       | 6.81 | 0    | 0.01 |
+---------+------+------+------+
| 8       | 0    | 0    | 0.01 |
+---------+------+------+------+
| 16      | 0    | 0    | 0    |
+---------+------+------+------+
| 32      | 0    | 0    | 0.01 |
+---------+------+------+------+

Hackbench
---------
Creates a specified number of pairs of schedulable entities
which communicate via either sockets or pipes and time how long  it
takes for each pair to send data back and forth.

Machine - IBM Power 9

Scale of measurement:
1. Time (s)
2. Power (watts)
Time is normalized

+---------+----------+----------------------+-------------------+
| Loops   | TEO Time | Wt. TEO Time Sockets | Wt. TEO Time Pipe |
+---------+----------+----------------------+-------------------+
| 100     | 100      | 95.23                | 87.09             |
+---------+----------+----------------------+-------------------+
| 1000    | 100      | 105.81               | 98.67             |
+---------+----------+----------------------+-------------------+
| 10000   | 100      | 99.33                | 92.73             |
+---------+----------+----------------------+-------------------+
| 100000  | 100      | 98.88                | 101.99            |
+---------+----------+----------------------+-------------------+
| 1000000 | 100      | 100.04               | 100.2             |
+---------+----------+----------------------+-------------------+

Power :Socket: Consistent between 135-140 watts for both TEO and Wt. TEO
       Pipe: Consistent between 125-130 watts for both TEO and Wt. TEO

Pratik Rajesh Sampat (1):
  Weighted approach to gather and use history in TEO governor

 drivers/cpuidle/governors/teo.c | 96 +++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 5 deletions(-)

-- 
2.17.1

